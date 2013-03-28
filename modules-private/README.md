Place your own infrastructure modules in this directory.

The module called 'role' should have role subclasses that define the full
configuration needed for a machine. Roles should be assigned to machines on a
1:1 ratio. If two machines have different components, then they should have
separate roles. All first-subclass roles should inherit from the base role (ie,
`role::website inherits role`). Roles that are extensions of other roles should
inherit their parent roles (ie, `role::website::assets inherits role::website`).
Roles should be entirely composed of `include profile::*` if possible. Roles
should not declare resources or other roles.

The module called 'profile' should have profile subclasses that define the
specific business-logic for a specific piece of technology and related tech-
classes that do not otherwise have their own profile. Hiera queries should be
executed here for any parameters that will be passed to the required classes.
`create_resources()` may be called here. Profiles should not inherit. Profiles
should be entirely composed out of class declarations and `create_resources`
calls for defined types if possible. Profiles should not declare resources or
other profiles.

Modules that are not called 'role' or 'profile' are called 'tech modules', and should
perform a technology-oriented task and have minimal resource-level interaction
with other modules. They should expose an API entirely based on class-parameters
and defined types to configure the software in a portable way. They should also
be built in such a way that other organizations with vastly different
infrastructure could theoretically benefit from them with minimal changes. Tech
modules should receive all their configuration via parameters or well-documented
facts. They should have no silently-discovered configuration other than
osfamily, and conventions should be overridable by passing overridden default
parameters or facts.
