
# Contributing

When contributing to this repository, please first discuss the change you wish to make via issue, email, or any other method with the dev team.

*The maintainers of this repo are:*
- Laura Lindzey (APL)
- Brian Bingham (NPS) 
- Kris Krasnosky (URI)

## Branching model

We've adopted a branching strategy to ensure that this repo always have a
stable version readily available for UUV operations.


### Developing new code

1. *main* is the production branch, so no direct commits allowed.
2. You should develop new code under a *feature branch* (typically branched off
   main)
    * Each feature should have a dedicated branch
    * **Keep your feature branch up to date with main to avoid merge conflicts**
3. Once you're done developing your new feature and have tested it in sim / lab
  / test tank, create a pull-request to a release branch.
4. Once approved, the feature branch will be merged to a release branch and
   closed. Release branches will be tested at sea (possibly for several
   deployments) and may include more than one feature
5. Push further fixes to the release branch
6. Finally, merge the release branch to Master via pull request

Example:

            git checkout main
            git pull --rebase
            git checkout -b feature/2019-04-29-cool-new-feature
            # develop on your feature branch...

            *--A---B----------------------C--  main
                    \                    /
                     \            *--R--S    release
                      \             /
                       N---O---P---Q    cool feature

            # done? create PR to release and schedule a CR

Don't forget to keep your feature branch up to date with main!

Say, you have:

            *--A---B---C---D---E--- main
                \
                 N---O---P---Q----- feature

            # run
            git fetch origin # update origin/main from the server
            git stash # if you have uncommitted local changes

            # then do
            git checkout main # check out your local tracking branch ...
            git pull --rebase # ... and bring it up to date
            git checkout feature/2019-04-29-cool-new-feature # go back to your feature branch
            git merge master # do the actual merge to obtain:

             *--A---B---C---D---E--- main
                 \               \
                  N---O---P---Q---R-- feature

            # after merging, don't forget to
            git stash pop

### Fixing/updating existing code

1. Create a bugfix/hotfix branch and commit your changes to it. Each fix should have a dedicated branch
2. Test in sim / lab / test tank / at sea!
3. Create a pull request to Master
4. Propagate changes to release and feature branches

Example:

            git checkout main
            git pull --rebase
            git checkout -b bugfix/2019-04-29-fix-nasty-bug
            # commit changes to your fix branch...

             *--A---B-----C--  main
                     \    /\
              bugfix  X--Y  \
                             \
                  N---O---P---Q some release

            # done? create a PR to main and merge to release/feature

Note about hotfixes: please consider creating a feature branch depending on the scope of the changes you're introducing.

## Code of conduct

1. Never commit code that brakes the build

        # also, please test your changes by running the project's unit/regression tests
        cd path/to/hydrographic_msgs

        # run
        ??? # to execute unit tests and ...
        ??? # ... for regression tests

2. Make sure your code meets the project's style guidelines before committing

        # keeping your code in style is easy!
        make pretty # to format the code (ansi, aStyle 2.05.1) and ...
        make cxxcheck # ... to check Cxx style

3. If you're making changes in a sub-repo make sure sub-repo pointers point to the right commit

        # quickly test using:
        cd path/to/hydrographic_msgs
        git submodule update --recursive
        # verify the intended commits are checked out in the sub-repos

### Git branch names

1. Feature branch: `feature/yyyy-mm-dd-descriptive-feature-name`
2. Bugfix branch: `bugfix/yyyy-mm-dd-fix-describe-bug`
3. Hotfix branch: `hotfix/yyyy-mm-dd-some-descriptive-name`
3. Release branch: `release/yyyy-mm-dd`

### Git commit messages

1. Commit messages should succinctly describe the changes you're introducing
2. Use the present tense ("Add feature" not "Added feature")
3. Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
4. Limit the first line to 72 characters or less

