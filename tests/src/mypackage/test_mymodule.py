import mypackage.mymodule as mymodule


def test_get_class_name():
    output = mymodule.get_class_name(42)
    assert output == "int"
