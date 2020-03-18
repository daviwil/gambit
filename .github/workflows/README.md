# Gambit Build Notes

These scripts will produce builds of Gambit for Linux and Windows using whatever latest
commit is in this repository.  The aim is to have my own builds of Gambit stashed somewhere
so that they can be used in CI for other repos without having to rebuild Gambit everywhere.

One important thing I learned while trying to get the Windows build running is that it's
better to force gsc-boot.exe to be rebuilt to avoid compiler issues about missing APIs, etc.
I don't have a good explanation for why it happens, but I was never able to get a clean build
until I found a way to force the bootstrapper to be built every time.  It was a challenge on
GitHub Actions for some reason, the logic in the makefile which checks whether to build the
bootstrapper (which is based on checking Git tags) never worked correctly.  I've basically
commented it out using `makefile.patch`.

I also tried in vain to get everything to build with MinGW64 so that I could have a more
consistent build process across all platforms but I kept running into compiler errors.  One
day I'd like to try that again but for now I think I'm happy enough just using MSVC (which
also took far too much effort to accomplish).  The trick to making MinGW64 work may also be
to force bootstrapping.  I was also building with the v4.9.3 tag in the past; this might have
been the issue for my MinGW64 troubles because bootstrapping won't happen on a release tag.

In the future I'll have to re-evaluate the parameters I'm giving to `./configure` to ensure
I'm getting the most optimized and effective builds on each platform.

### Helpful Resources

- https://github.com/gambit/gambit/issues/480#issuecomment-581215837
- https://www.devdungeon.com/content/install-gcc-compiler-windows-msys2-cc
- https://github.com/actions/virtual-environments/blob/master/images/win/Windows2019-Readme.md