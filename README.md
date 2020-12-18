# Website Archiver
An easy way to archive any publicly accessible website locally using [Docker](https://docker.com/) and [HTTrack](https://www.httrack.com/).

## Specifying sites

This image uses a single YAML file, `website-archiver.yml` to specify which sites to back up and how.

```yaml
webarchiver_sites:
  - site: "https://example.com"
    dest: "/public/example.com"
```

Where:
* **site** is the site URL. Required.
* **dest** is the path in the container to save the file. Required.

If you want to archive multiple sites, simply add another entry:

```yaml
webarchiver_sites:
  - site: "https://example.com"
    dest: "/public/example.com"
  - site: "https://example.net"
    dest: "/public/example.net"

```


### Specifying additional URL patterns

You may wish to include additional URL patterns along with the `site`. This could be CSS or JS files or media files. Do so with `additional_url_patterns`:

```yaml
webarchiver_sites:
  - site: "https://example.com"
    dest: "/public/example.com"
    additional_url_patterns:
      - "+https://example.com/*"
      - "+*.css"
      - "+*.js"
      - "+mime:image/*"
      - "+mime:video/*"
      - "+mime:audio/*"
```

Where:

* **additional_url_patterns** is a list of patterns to include in the archive. Optional, defaults to CSS, JS, and media files.

You may also restrict your crawl to a folder of the `site` by including it in `additional_url_patterns`. For example, to craw only the URL `https://example.com/folder` and any page therein:

```yaml
  - site: "https://example.com/folder"
    dest: "/public/example.com"
    additional_url_patterns:
      - "+https://example.com/folder/*"
      - "+*.css"
      - "+*.js"
      - "+mime:image/*"
      - "+mime:video/*"
      - "+mime:audio/*"
```

### Controlling depth

The archiver will attempt to follow all links it finds when backing up a site. You can control this with `max_links`:

```yaml
webarchiver_sites:
  - site: "https://example.com"
    dest: "/public/example.com"
    max_links: 500000
```

Where:

* **max_links** The maximum depth of links to back up. Optional, defaults to 500000.

Note, setting this too low can cause the archiver to fail.

### Following robots.txt.

You can instruct the archiver to follow links in robots.txt and meta tags using `follow_robots_txt`:

```yaml
webarchiver_sites:
  - site: "https://example.com"
    dest: "/public/example.com"
    follow_robot_txt: "never"
```

Where the value of `follow_robot_txt` is:
* **never** Never follow. Default.
* **sometimes** Follow some links. See httrack documentation for more info.
* **always** Follow even more.
* **even strict** Follow even strictly disallowed links.

### Other options

You can control the archive further with the following options:

```yaml
webarchiver_sites:
  - site: "https://example.com"
    dest: "/public/example.com"
    extra_log: yes
    single_log: yes
    disable_security_limits: yes
    update: yes
    max_transfer_rate: 0
    max_links: 500000
    include_near_files: yes
```

Where:

* **extra_log** Write extra information to the log. Optional, defaults to `yes`.
* **single_log** Write to a single log file per archive. Optional, defaults to `yes`.
* **disable_security_limits** Bypass internal limits on bandwidth abuse. Optional, defaults to `yes`.
* **update** Update the existing archive if it was previously taken. Optional, defaults to `yes`.
* **max_transfer_rate** The maximum transfer rate in bytes/sec. Optional, defaults to no limit.

## Using this image

You can run this image in several ways. First, create `website-archiver.yml` using the `website-archiver.yml.example` file as a template.

To run using docker:

```shell
docker run -it \
  --volume `pwd`/public:/public  \
  --volume `pwd`/website-archiver.yml://config/httrack/website-archiver.yml
  ten7/website-archiver
```

Or, to use the included docker-compose.yml file:

```shell
docker-compose run httrack
```

## Debugging

This container uses [Ansible](https://www.ansible.com/) to perform start-up tasks. To get even more verbose output from the start up scripts, set the `ANSIBLE_VERBOSITY` environment variable to `4`.

If the container will not start due to a failure of the entrypoint, set the `WEBARCHIVER_SKIP_ENTRYPOINT` environment variable to `true` or `1`, then restart the container.

## Hosting a pages site on Gitlab

There is an example `.gitlab-ci.yml` file named `.gitlab-ci.yml.example` that can be used to host a site archived into the default `/public` folder using [Gitlab Pages](https://about.gitlab.com/stages-devops-lifecycle/pages/). Simply copy the file and push your repo to Gitlab and you'll be set.

## License

Website Archiver is licensed under GPLv3. See `LICENSE` for the complete language.
