if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface DataDisplaySection_Params {
    isDark?: boolean;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
import { SectionLabel } from "@bundle:com.riclava.dsshowcase/entry/ets/sections/Widgets";
import { AppAvatar, AppAvatarShape } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/components/AppAvatar";
import { AppBadge } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/components/AppBadge";
export class DataDisplaySection extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: DataDisplaySection_Params) {
    }
    updateStateVars(params: DataDisplaySection_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__isDark.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__isDark.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __isDark: ObservedPropertyAbstractPU<boolean>;
    get isDark() {
        return this.__isDark.get();
    }
    set isDark(newValue: boolean) {
        this.__isDark.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.alignItems(HorizontalAlign.Start);
            Column.width('100%');
            Column.margin({ bottom: Token.space.lg });
        }, Column);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // Avatar
                    SectionLabel(this, { text: 'Avatar · 头像' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/DataDisplaySection.ets", line: 13, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Avatar · 头像'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Avatar · 头像'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width('100%');
            Row.margin({ bottom: Token.space.md });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.sm });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppAvatar(this, { text: 'A', avatarSize: 32, bgColor: Token.color.primary() }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/DataDisplaySection.ets", line: 15, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'A',
                            avatarSize: 32,
                            bgColor: Token.color.primary()
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'A', avatarSize: 32, bgColor: Token.color.primary()
                    });
                }
            }, { name: "AppAvatar" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.sm });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppAvatar(this, { text: 'B', avatarSize: 40, bgColor: Token.color.secondary() }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/DataDisplaySection.ets", line: 17, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'B',
                            avatarSize: 40,
                            bgColor: Token.color.secondary()
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'B', avatarSize: 40, bgColor: Token.color.secondary()
                    });
                }
            }, { name: "AppAvatar" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.sm });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppAvatar(this, { text: 'C', avatarSize: 48, bgColor: Token.color.warning() }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/DataDisplaySection.ets", line: 19, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'C',
                            avatarSize: 48,
                            bgColor: Token.color.warning()
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'C', avatarSize: 48, bgColor: Token.color.warning()
                    });
                }
            }, { name: "AppAvatar" });
        }
        __Common__.pop();
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppAvatar(this, { text: 'D', avatarSize: 48, shape: AppAvatarShape.Rounded, bgColor: Token.color.info() }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/DataDisplaySection.ets", line: 21, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'D',
                            avatarSize: 48,
                            shape: AppAvatarShape.Rounded,
                            bgColor: Token.color.info()
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'D', avatarSize: 48, shape: AppAvatarShape.Rounded, bgColor: Token.color.info()
                    });
                }
            }, { name: "AppAvatar" });
        }
        Row.pop();
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // Badge on avatar
                    SectionLabel(this, { text: 'Badge · 徽标' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/DataDisplaySection.ets", line: 27, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Badge · 徽标'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Badge · 徽标'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width('100%');
            Row.margin({ bottom: Token.space.md });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create({ alignContent: Alignment.TopEnd });
            Stack.margin({ right: Token.space.lg });
        }, Stack);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppAvatar(this, { text: 'M', avatarSize: 48, bgColor: Token.color.primary() }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/DataDisplaySection.ets", line: 30, col: 11 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'M',
                            avatarSize: 48,
                            bgColor: Token.color.primary()
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'M', avatarSize: 48, bgColor: Token.color.primary()
                    });
                }
            }, { name: "AppAvatar" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppBadge(this, { count: 5 }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/DataDisplaySection.ets", line: 31, col: 11 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            count: 5
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        count: 5
                    });
                }
            }, { name: "AppBadge" });
        }
        Stack.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create({ alignContent: Alignment.TopEnd });
            Stack.margin({ right: Token.space.lg });
        }, Stack);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppAvatar(this, { text: 'N', avatarSize: 48, bgColor: Token.color.secondary() }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/DataDisplaySection.ets", line: 36, col: 11 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'N',
                            avatarSize: 48,
                            bgColor: Token.color.secondary()
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'N', avatarSize: 48, bgColor: Token.color.secondary()
                    });
                }
            }, { name: "AppAvatar" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppBadge(this, { count: 128 }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/DataDisplaySection.ets", line: 37, col: 11 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            count: 128
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        count: 128
                    });
                }
            }, { name: "AppBadge" });
        }
        Stack.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create({ alignContent: Alignment.TopEnd });
        }, Stack);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppAvatar(this, { text: 'O', avatarSize: 48, bgColor: Token.color.info() }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/DataDisplaySection.ets", line: 42, col: 11 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'O',
                            avatarSize: 48,
                            bgColor: Token.color.info()
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'O', avatarSize: 48, bgColor: Token.color.info()
                    });
                }
            }, { name: "AppAvatar" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppBadge(this, { dot: true }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/DataDisplaySection.ets", line: 43, col: 11 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            dot: true
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        dot: true
                    });
                }
            }, { name: "AppBadge" });
        }
        Stack.pop();
        Row.pop();
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // Circular progress
                    SectionLabel(this, { text: 'Progress · 环形进度' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/DataDisplaySection.ets", line: 50, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Progress · 环形进度'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Progress · 环形进度'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width('100%');
            Row.alignItems(VerticalAlign.Center);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Progress.create({ value: 30, total: 100, type: ProgressType.Ring });
            Progress.color(Token.color.primary());
            Progress.backgroundColor(Token.color.outline());
            Progress.width(56);
            Progress.height(56);
            Progress.margin({ right: Token.space.lg });
        }, Progress);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Progress.create({ value: 70, total: 100, type: ProgressType.Ring });
            Progress.color(Token.color.success());
            Progress.backgroundColor(Token.color.outline());
            Progress.width(56);
            Progress.height(56);
            Progress.margin({ right: Token.space.lg });
        }, Progress);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            LoadingProgress.create();
            LoadingProgress.width(40);
            LoadingProgress.height(40);
            LoadingProgress.color(Token.color.primary());
        }, LoadingProgress);
        Row.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
