#
# Init file for fish
#

#
# Some things should only be done for login terminals
#

if test -f /usr/share/terminfo/g/gnome-256color
	export TERM=gnome-256color
end

if status --is-login

	#
	# Set some value for LANG if nothing was set before, and this is a
	# login shell.
	#

	if not set -q LANG >/dev/null
		set -gx LANG en_US.UTF-8
	end

	# Check for i18n information in
	# /etc/sysconfig/i18n

	if test -f /etc/sysconfig/i18n
		eval (cat /etc/sysconfig/i18n |sed -ne 's/^\([a-zA-Z]*\)=\(.*\)$/set -gx \1 \2;/p')
	end

	#
	# Put linux consoles in unicode mode.
	#

	if test "$TERM" = linux
		if expr "$LANG" : ".*\.[Uu][Tt][Ff].*" >/dev/null
			if which unicode_start >/dev/null
				unicode_start
			end
		end
	end
end

function fish_prompt --description 'Write out the prompt'
	if not set -q __fish_prompt_hostname
		set __fish_prompt_hostname (hostname | cut -d . -f 1)
	end

	if not set -q __fish_prompt_normal
		set -g __fish_prompt_normal (set_color normal)
	end

	if not set -q __git_cb
		set __git_cb ":["(set_color brown)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)"]"
	end

	printf '%s@%s %s%s%s%s> ' \
		(whoami) $__fish_prompt_hostname \
		(set_color $fish_color_cwd) (prompt_pwd) (set_color normal) \
		$__git_cb
end
