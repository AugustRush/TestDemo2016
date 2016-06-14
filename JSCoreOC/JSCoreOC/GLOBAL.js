
var __global__ = this;

var OCModel = function(type,name) {
    this._type = type;
    this._name = name;
}

var ImportClass = function(name) {
    if (!__global__[name]) {
        var m = OCModel(1,name);
        __global__[name] = m;
        return m;
    }
    return __global__[name];
}

var ImportMethod = function(method) {
    if (!__global__[method]) {
        var m = OCModel(2,method);
        __global__[method] = m;
        return m;
    }
    return __global__[method]
}

function NewObject(string) {
    var arr = string.split('.')
    createObject(arr[0],arr)
}
