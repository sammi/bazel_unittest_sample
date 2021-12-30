load("@bazel_skylib//lib:unittest.bzl", "asserts", "analysistest")
load(":myrules.bzl", "myrule", "MyInfo")

def __provider_contents_test_impl(ctx):
    env = analysistest.begin(ctx)
    target_under_test = analysistest.target_under_test(env)
    asserts.equals(env, "some value", target_under_test[MyInfo].val)
    return analysistest.end(env)

provider_contents_test = analysistest.make(__provider_contents_test_impl)

def _test_provider_contents():
    myrule(name = "provider_contents_subject", tags = ["manual"])
    provider_contents_test(
        name = "provider_contents_test",
        target_under_test = ":provider_contents_subject"
    )

def myrules_test_suite(name):
    _test_provider_contents()
    native.test_suite(
        name = name,
        tests = [
            ":provider_contents_test",
        ]
    )
