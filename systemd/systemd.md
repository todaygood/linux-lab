
ContainerInterface

https://www.freedesktop.org/wiki/Software/systemd/ContainerInterface/


https://www.freedesktop.org/wiki/Software/systemd/PaxControlGroups/

https://www.freedesktop.org/wiki/Software/systemd/ControlGroupInterface/

# systemd's Resource Control Concepts

Systemd provides three unit types that are useful for the purpose of resource control:

Services, encapsulate a number of processes that are started and stopped by systemd based on configuration. Services are named in the style of quux.service.

Scopes, encapsulate a number of processes that are started and stopped by arbitrary processes via fork(), and then registered at runtime with PID1. Scopes are named in the style of wuff.scope.

Slices, may be used to group a number of services and scopes together in a hierarchial tree. Slices do not contain processes themselves, but the services and slices contained in them do. Slices are named in the style of foobar-waldo.slice, where the path to the location of the slice in the tree is encoded in the name with "-" as separator for the path components (foobar-waldo.slice is hence a subslice of foobar.slice). There's one special slices defined, -.slice, which is the root slice of all slices (foobar.slice is hence subslice of -.slice). This is similar how in regular file paths, "/" denotes the root directory.
