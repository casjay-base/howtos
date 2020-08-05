## GitLab configuration settings
## These are my Git lab Settings

external_url 'https://myserverdomainname'
gitlab_rails['time_zone'] = 'America/New_York'
gitlab_rails['gitlab_email_enabled'] = true
gitlab_rails['gitlab_email_from'] = 'no-reply@myserverdomainname'
gitlab_rails['gitlab_email_display_name'] = 'CasjaysDev SCM'
gitlab_rails['gitlab_email_reply_to'] = 'no-reply@myserverdomainname'
gitlab_rails['gitlab_email_subject_suffix'] = ''

gitlab_rails['gitlab_default_theme'] = 6
gitlab_rails['gitlab_default_projects_features_issues'] = true
gitlab_rails['gitlab_default_projects_features_merge_requests'] = true
gitlab_rails['gitlab_default_projects_features_wiki'] = true
gitlab_rails['gitlab_default_projects_features_snippets'] = true
gitlab_rails['gitlab_default_projects_features_builds'] = true
gitlab_rails['gitlab_default_projects_features_container_registry'] = true

gitlab_rails['gitlab_issue_closing_pattern'] = "((?:[Cc]los(?:e[sd]?|ing)|[Ff]ix(?:e[sd]|ing)?|[Rr]esolv(?:e[sd]?|ing)|[Ii]mplement(?:s|ed|ing)?)(:?) +(?:(?:issues? +)?%{issue_ref}(?:(?:, *| +and +)?)|([A-Z][A-Z0-9_]+-\d+))+)"

gitlab_rails['gravatar_plain_url'] = 'http://www.gravatar.com/avatar/%{hash}?s=%{size}&d=identicon'
gitlab_rails['gravatar_ssl_url'] = 'https://secure.gravatar.com/avatar/%{hash}?s=%{size}&d=identicon'

gitlab_rails['stuck_ci_jobs_worker_cron'] = "0 0 * * *"
gitlab_rails['expire_build_artifacts_worker_cron'] = "50 * * * *"
gitlab_rails['pipeline_schedule_worker_cron'] = "41 * * * *"
gitlab_rails['ci_archive_traces_cron_worker_cron'] = "17 * * * *"
gitlab_rails['repository_check_worker_cron'] = "20 * * * *"
gitlab_rails['admin_email_worker_cron'] = "0 0 * * 0"
gitlab_rails['repository_archive_cache_worker_cron'] = "0 * * * *"
gitlab_rails['pages_domain_verification_cron_worker'] = "*/15 * * * *"

gitlab_rails['webhook_timeout'] = 10

gitlab_rails['trusted_proxies'] = []

# gitlab_rails['monitoring_whitelist'] = ['127.0.0.0/8', '::1/128']
# gitlab_rails['monitoring_unicorn_sampler_interval'] = 10
# gitlab_rails['incoming_email_enabled'] = true
# gitlab_rails['incoming_email_address'] = "gitlab-incoming+%{key}@gmail.com"
# gitlab_rails['incoming_email_email'] = "gitlab-incoming@gmail.com"
# gitlab_rails['incoming_email_password'] = "[REDACTED]"

# gitlab_rails['incoming_email_host'] = "imap.gmail.com"
# gitlab_rails['incoming_email_port'] = 993
# gitlab_rails['incoming_email_ssl'] = true
# gitlab_rails['incoming_email_start_tls'] = false

# gitlab_rails['incoming_email_mailbox_name'] = "inbox"
# gitlab_rails['incoming_email_idle_timeout'] = 60

gitlab_rails['artifacts_enabled'] = true
# gitlab_rails['lfs_enabled'] = true
gitlab_rails['usage_ping_enabled'] = true

gitlab_rails['gitlab_signup_enabled'] = true
gitlab_rails['omniauth_enabled'] = true
gitlab_rails['omniauth_allow_single_sign_on'] = ['github', 'google_oauth2', 'saml']
gitlab_rails['omniauth_block_auto_created_users'] = true
gitlab_rails['sync_profile_from_provider'] = ['github', 'google_oauth2', 'saml']
gitlab_rails['sync_profile_attributes'] = ['name', 'email', 'location']

gitlab_rails['manage_backup_path'] = true

#gitlab_rails['gitlab_shell_ssh_port'] = 22
gitlab_rails['gitlab_shell_git_timeout'] = 800

# gitlab_rails['extra_google_analytics_id'] = '_your_tracking_id'
# gitlab_rails['extra_piwik_url'] = '_your_piwik_url'
# gitlab_rails['extra_piwik_site_id'] = '_your_piwik_site_id'

gitlab_rails['auto_migrate'] = true
gitlab_rails['rake_cache_clear'] = true

#gitlab_rails['smtp_enable'] = true
#gitlab_rails['smtp_address'] = "smtp.myserverdomainname"
#gitlab_rails['smtp_port'] = 25

registry_external_url 'https://registry.myserverdomainname'
registry['enable'] = true
registry_nginx['enable'] = true
registry_nginx['ssl_certificate'] = "/etc/letsencrypt/live/domain/fullchain.pem"
registry_nginx['ssl_certificate_key'] = "/etc/letsencrypt/live/domain/privkey.pem"
registry_nginx['proxy_set_headers'] = {
 "Host" => "$http_host",
 "X-Real-IP" => "$remote_addr",
 "X-Forwarded-For" => "$proxy_add_x_forwarded_for",
 "X-Forwarded-Proto" => "https",
 "X-Forwarded-Ssl" => "on"
}

gitlab_workhorse['enable'] = true

unicorn['worker_timeout'] = 300
unicorn['worker_processes'] = 8

nginx['enable'] = true
nginx['listen_addresses'] = ["0.0.0.0", "[::]"]
nginx['client_max_body_size'] = '250m'
nginx['redirect_http_to_https'] = true
nginx['redirect_http_to_https_port'] = 80
nginx['ssl_certificate'] = "/etc/letsencrypt/live/domain/fullchain.pem"
nginx['ssl_certificate_key'] = "/etc/letsencrypt/live/domain/privkey.pem"
nginx['ssl_ciphers'] = "ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256"
nginx['ssl_prefer_server_ciphers'] = "on"
nginx['ssl_protocols'] = "TLSv1.1 TLSv1.2"
nginx['ssl_session_cache'] = "builtin:1000  shared:SSL:10m"
nginx['ssl_session_timeout'] = "5m"
nginx['hsts_max_age'] = 31536000
nginx['hsts_include_subdomains'] = true
nginx['gzip_enabled'] = true
nginx['custom_nginx_config'] = "include /etc/gitlab/nginx/*.conf;"

pages_external_url 'https://pages.myserverdomainname'
pages_nginx['redirect_http_to_https'] = true
pages_nginx['ssl_certificate'] = "/etc/letsencrypt/live/domain/fullchain.pem"
pages_nginx['ssl_certificate_key'] = "/etc/letsencrypt/live/domain/privkey.pem"
gitlab_pages['enable'] = true

##
gitlab_ci['gitlab_ci_all_broken_builds'] = true
gitlab_ci['gitlab_ci_add_pusher'] = true

mattermost_external_url 'https://teams.myserverdomainname'
mattermost_nginx['ssl_certificate'] = "/etc/letsencrypt/live/domain/fullchain.pem"
mattermost_nginx['ssl_certificate_key'] = "/etc/letsencrypt/live/domain/privkey.pem"

################################################################################

letsencrypt['enable'] = false
