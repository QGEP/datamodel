#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
***************************************************************************
    create_release.py
    ---------------------
    Date                 : April 2018
    Copyright            : (C) 2018 by Denis Rouzaud
    Email                : denis@opengis.ch
***************************************************************************
*                                                                         *
*   This program is free software; you can redistribute it and/or modify  *
*   it under the terms of the GNU General Public License as published by  *
*   the Free Software Foundation; either version 2 of the License, or     *
*   (at your option) any later version.                                   *
*                                                                         *
***************************************************************************
"""

__author__ = 'Denis Rouzaud'
__date__ = 'April 2018'
__copyright__ = '(C) 2018,Denis Rouzaud'
# This will get replaced with a git SHA1 when you do a git archive
__revision__ = '$Format:%H$'


import http.client
import os
import json
import subprocess


def files_description(version):
    return """

## Descriptions of the files
File | Description
------------ | -------------
qgep_v{version}_structure.sql | Contains the structure of tables and system schema content
qgep_v{version}_structure_with_value_lists.sql | Contains the structure of tables, system schema data and value lists data
qgep_v{version}_demo_data.backup | Data-only backup of the `qgep_od` schema (i.e. ordinary data) from demonstration set of data
qgep_v{version}_structure_and_demo_data.backup | Complete backup with structure and data of the demonstration set of data

* If you plan to **use QGEP for production**, it is more likely you will be using the plain SQL `qgep_v{version}_structure_with_value_lists.sql`.
* If you want to **give a try at QGEP**, you will likely restore the `qgep_v{version}_structure_and_demo_data.backup` backup file.
""".format(version=version)


def create_dumps():
    """
    Creates all dumps
    :return: the files names in a list
    """
    file_s = create_plain_structure_only()
    file_v = create_plain_value_list(file_s)
    file_d = create_backup_data()
    file_b = create_backup_complete()
    return [file_s, file_v, file_d, file_b]


def create_plain_structure_only():
    """
    Create a plain SQL dump of data structure of all schemas and the content of pum_sys.inf
    :return: the file name of the dump
    """
    print('travis_fold:start:plain SQL structure only')

    # structure
    dump_s = 'qgep_v{version}_structure.sql'.format(
        version=os.environ['TRAVIS_TAG'])

    print('Creating dump {}'.format(dump_s))
    dump_file_s = '/tmp/{dump}'.format(dump=dump_s)
    subprocess.call(['pg_dump',
                     '--format', 'plain',
                     '--schema-only',
                     '--file', dump_file_s,
                     '--exclude-schema', 'public',
                     'qgep_prod']
                    )

    # dump all from qgep_sys except logged_actions
    dump_i = 'qgep_v{version}_pum_info.sql'.format(
        version=os.environ['TRAVIS_TAG'])
    print('Creating dump {}'.format(dump_i))
    dump_file_i = '/tmp/{dump}'.format(dump=dump_i)
    subprocess.call(['pg_dump',
                     '--format', 'plain',
                     '--data-only',
                     '--file', dump_file_i,
                     '--schema', 'qgep_sys',
                     '--exclude-table', 'qgep_sys.logged_actions',
                     'qgep_prod']
                    )
    print('Concatenating the 2 dumps')
    with open(dump_file_i) as f:
        dump_data = f.read()
    with open(dump_file_s, "a") as f:
        f.write(dump_data)

    print('travis_fold:end:plain SQL structure only')

    return dump_file_s


def create_plain_value_list(structure_dump_file):
    """
    Create a plain SQL dump of data structure (result of create_structure_only)
    with value list content
    :return: the file name of the dump
    """
    print('travis_fold:start:value lists dump')

    dump = 'qgep_v{version}_structure_with_value_lists.sql'.format(
        version=os.environ['TRAVIS_TAG'])

    print('Creating dump {}'.format(dump))
    dump_file = '/tmp/{dump}'.format(dump=dump)

    subprocess.call(['pg_dump',
                     '--format', 'plain',
                     '--blobs',
                     '--data-only',
                     '--file', dump_file,
                     '--schema', 'qgep_vl',
                     'qgep_prod']
                    )

    print('Concatenating the 2 dumps')
    with open(dump_file) as f:
        dump_data = f.read()
    with open(structure_dump_file) as f:
        structure_dump_data = f.read()
    with open(dump_file, 'w') as f:
        f.write(structure_dump_data)
        f.write('\n\n\n-- Value lists dump --\n\n')
        f.write(dump_data)

    print('travis_fold:end:value lists dump')
    
    return dump_file


def create_backup_data():
    """
    Create a data-only dump (without VL and pum_info)
    :return: the file name
    """
    # Create data-only dumps (with sample data)
    dump = 'qgep_v{version}_demo_data.backup'.format(
        version = os.environ['TRAVIS_TAG'])
    print('travis_fold:start:{}'.format(dump))
    print('Creating dump {}'.format(dump))
    dump_file = '/tmp/{dump}'.format(dump=dump)
    subprocess.call(['pg_dump',
                     '--format', 'custom',
                     '--blobs',
                     '--data-only',
                     '--compress', '5',
                     '--file', dump_file,
                     '--table', 'qgep_od.*',
                     '--table', 'qgep_sys.logged_actions',
                     'qgep_prod']
                    )
    print('travis_fold:end:{}'.format(dump))
    return dump_file


def create_backup_complete():
    """
    Create data + structure dump
    :return: the file name
    """
    # Create data + structure dumps (with sample data)
    dump = 'qgep_v{version}_structure_and_demo_data.backup'.format(
        version = os.environ['TRAVIS_TAG'])
    print('travis_fold:start:{}'.format(dump))
    print('Creating dump {}'.format(dump))
    dump_file = '/tmp/{dump}'.format(dump=dump)
    subprocess.call(['pg_dump',
                     '--format', 'custom',
                     '--blobs',
                     '--compress', '5',
                     '--file', dump_file,
                     '-N', 'public',
                     'qgep_prod']
                    )
    print('travis_fold:end:{}'.format(dump))

    return dump_file


def main():
    """
    Publish the files in a release on github
    If a release already exist, it will copy its data (title, description, etc),
    delete it and create a new one with the same data and adding the dump files
    """
    if 'TRAVIS_TAG' not in os.environ or not os.environ['TRAVIS_TAG']:
        print('No git tag: not deploying anything')
        return
    elif os.environ['TRAVIS_SECURE_ENV_VARS'] != 'true':
        print('No secure environment variables: not deploying anything')
        return
    else:
        print('Creating release from tag {}'.format(os.environ['TRAVIS_TAG']))

    release_files = create_dumps()

    headers = {
        'User-Agent': 'Deploy-Script',
        'Authorization': 'token {}'.format(os.environ['GH_TOKEN'])
    }

    create_raw_data = {
        "tag_name": os.environ['TRAVIS_TAG'],
        "body": ""
    }

    # if a release exist with this tag_name delete it first
    # this allows to create the release from github website
    url = '/repos/{repo_slug}/releases/latest'.format(
        repo_slug=os.environ['TRAVIS_REPO_SLUG'])
    conn = http.client.HTTPSConnection('api.github.com')
    conn.request('GET', url, headers=headers)
    response = conn.getresponse()
    release = json.loads(response.read().decode())
    if 'tag_name' in release and release['tag_name'] == os.environ['TRAVIS_TAG']:
        print("Deleting release {}".format(release['tag_name']))
        url = '/repos/{repo_slug}/releases/{id}'.format(
            repo_slug=os.environ['TRAVIS_REPO_SLUG'],
            id=release['id'])
        conn = http.client.HTTPSConnection('api.github.com')
        conn.request('DELETE', url, headers=headers)
        response = conn.getresponse()
        if response.status == 204:
            print('Existing release deleted!')
            create_raw_data["target_commitish"] = release['target_commitish']
            create_raw_data["name"] = release['name']
            create_raw_data["body"] = release['body']
        else:
            print('Failed to delete release!')
            print('Github API replied:')
            print('{} {}'.format(response.status, response.reason))

    create_raw_data["body"] += files_description(os.environ['TRAVIS_TAG'])

    data = json.dumps(create_raw_data)
    url = '/repos/{repo_slug}/releases'.format(
        repo_slug=os.environ['TRAVIS_REPO_SLUG'])
    conn = http.client.HTTPSConnection('api.github.com')
    conn.request('POST', url, body=data, headers=headers)
    response = conn.getresponse()
    release = json.loads(response.read().decode())

    if 'upload_url' not in release:
        print('Failed to create release!')
        print('Github API replied:')
        print('{} {}'.format(response.status, response.reason))
        print(repr(release))
        exit(-1)

    conn = http.client.HTTPSConnection('uploads.github.com')
    for release_file in release_files:
        _, filename = os.path.split(release_file)
        headers['Content-Type'] = 'text/plain'
#        headers['Transfer-Encoding'] = 'gzip'
        url = '{release_url}?name={filename}'.format(release_url=release['upload_url'][:-13], filename=filename)
        print('Upload to {}'.format(url))

        with open(release_file, 'rb') as f:
            conn.request('POST', url, f, headers)

        response = conn.getresponse()
        result = response.read()
        if response.status != 201:
            print('Failed to upload filename {filename}'.format(filename=filename))
            print('Github API replied:')
            print('{} {}'.format(response.status, response.reason))
            print(repr(json.loads(result.decode())))


if __name__ == "__main__":
    main()
