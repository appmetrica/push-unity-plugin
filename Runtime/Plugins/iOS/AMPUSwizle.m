
#import "AMPUSwizle.h"
#import "UnityAppController.h"

#import <objc/runtime.h>

void ampu_unityAppControllerMethodsSwap(SEL origSel, SEL ampuSel)
{
    Class cls = [UnityAppController class];
    Method origMethod = class_getInstanceMethod(cls, origSel);
    Method ampuMethod = class_getInstanceMethod(cls, ampuSel);

    if (origMethod != NULL) {
        method_exchangeImplementations(origMethod, ampuMethod);
    }
    else {
        const char *types = method_getTypeEncoding(ampuMethod);
        IMP ampuImp = method_getImplementation(ampuMethod);
        if (ampuImp != NULL) {
            class_addMethod(cls, origSel, ampuImp, types);
        }
    }
}
