if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface StatesSection_Params {
    isDark?: boolean;
}
interface StateCard_Params {
    isDark?: boolean;
    content?: () => void;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
import { SectionLabel } from "@bundle:com.riclava.dsshowcase/entry/ets/sections/Widgets";
import { StateView, StateKind } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/components/StateView";
import { Skeleton } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/components/Skeleton";
import { AppCard } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/components/AppCard";
class StateCard extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.content = undefined;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: StateCard_Params) {
        if (params.content !== undefined) {
            this.content = params.content;
        }
    }
    updateStateVars(params: StateCard_Params) {
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
    private __content;
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.backgroundColor(Token.color.surface());
            Column.borderRadius(Token.radius.md);
            Column.border({ width: 1, color: Token.color.divider() });
            Column.margin({ bottom: Token.space.md });
        }, Column);
        this.content.bind(this)();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
export class StatesSection extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: StatesSection_Params) {
    }
    updateStateVars(params: StatesSection_Params) {
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
                    let componentCall = new SectionLabel(this, { text: 'Loading' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 31, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Loading'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Loading'
                    });
                }
            }, { name: "SectionLabel" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new StateCard(this, {
                        content: () => {
                            {
                                this.observeComponentCreation2((elmtId, isInitialRender) => {
                                    if (isInitialRender) {
                                        let componentCall = new StateView(this, { kind: StateKind.Loading, title: '加载中', description: '正在获取数据…' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 33, col: 9 });
                                        ViewPU.create(componentCall);
                                        let paramsLambda = () => {
                                            return {
                                                kind: StateKind.Loading,
                                                title: '加载中',
                                                description: '正在获取数据…'
                                            };
                                        };
                                        componentCall.paramsGenerator_ = paramsLambda;
                                    }
                                    else {
                                        this.updateStateVarsOfChildByElmtId(elmtId, {
                                            kind: StateKind.Loading, title: '加载中', description: '正在获取数据…'
                                        });
                                    }
                                }, { name: "StateView" });
                            }
                        }
                    }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 32, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            content: () => {
                                {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        if (isInitialRender) {
                                            let componentCall = new StateView(this, { kind: StateKind.Loading, title: '加载中', description: '正在获取数据…' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 33, col: 9 });
                                            ViewPU.create(componentCall);
                                            let paramsLambda = () => {
                                                return {
                                                    kind: StateKind.Loading,
                                                    title: '加载中',
                                                    description: '正在获取数据…'
                                                };
                                            };
                                            componentCall.paramsGenerator_ = paramsLambda;
                                        }
                                        else {
                                            this.updateStateVarsOfChildByElmtId(elmtId, {
                                                kind: StateKind.Loading, title: '加载中', description: '正在获取数据…'
                                            });
                                        }
                                    }, { name: "StateView" });
                                }
                            }
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "StateCard" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new SectionLabel(this, { text: 'Empty' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 36, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Empty'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Empty'
                    });
                }
            }, { name: "SectionLabel" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new StateCard(this, {
                        content: () => {
                            {
                                this.observeComponentCreation2((elmtId, isInitialRender) => {
                                    if (isInitialRender) {
                                        let componentCall = new StateView(this, {
                                            kind: StateKind.Empty,
                                            title: '暂无内容',
                                            description: '这里还什么都没有，去添加第一条吧。',
                                            actionLabel: '新建'
                                        }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 38, col: 9 });
                                        ViewPU.create(componentCall);
                                        let paramsLambda = () => {
                                            return {
                                                kind: StateKind.Empty,
                                                title: '暂无内容',
                                                description: '这里还什么都没有，去添加第一条吧。',
                                                actionLabel: '新建'
                                            };
                                        };
                                        componentCall.paramsGenerator_ = paramsLambda;
                                    }
                                    else {
                                        this.updateStateVarsOfChildByElmtId(elmtId, {
                                            kind: StateKind.Empty,
                                            title: '暂无内容',
                                            description: '这里还什么都没有，去添加第一条吧。',
                                            actionLabel: '新建'
                                        });
                                    }
                                }, { name: "StateView" });
                            }
                        }
                    }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 37, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            content: () => {
                                {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        if (isInitialRender) {
                                            let componentCall = new StateView(this, {
                                                kind: StateKind.Empty,
                                                title: '暂无内容',
                                                description: '这里还什么都没有，去添加第一条吧。',
                                                actionLabel: '新建'
                                            }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 38, col: 9 });
                                            ViewPU.create(componentCall);
                                            let paramsLambda = () => {
                                                return {
                                                    kind: StateKind.Empty,
                                                    title: '暂无内容',
                                                    description: '这里还什么都没有，去添加第一条吧。',
                                                    actionLabel: '新建'
                                                };
                                            };
                                            componentCall.paramsGenerator_ = paramsLambda;
                                        }
                                        else {
                                            this.updateStateVarsOfChildByElmtId(elmtId, {
                                                kind: StateKind.Empty,
                                                title: '暂无内容',
                                                description: '这里还什么都没有，去添加第一条吧。',
                                                actionLabel: '新建'
                                            });
                                        }
                                    }, { name: "StateView" });
                                }
                            }
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "StateCard" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new SectionLabel(this, { text: 'Error' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 46, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Error'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Error'
                    });
                }
            }, { name: "SectionLabel" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new StateCard(this, {
                        content: () => {
                            {
                                this.observeComponentCreation2((elmtId, isInitialRender) => {
                                    if (isInitialRender) {
                                        let componentCall = new StateView(this, {
                                            kind: StateKind.Error,
                                            title: '加载失败',
                                            description: '网络异常，请稍后重试。',
                                            actionLabel: '重试'
                                        }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 48, col: 9 });
                                        ViewPU.create(componentCall);
                                        let paramsLambda = () => {
                                            return {
                                                kind: StateKind.Error,
                                                title: '加载失败',
                                                description: '网络异常，请稍后重试。',
                                                actionLabel: '重试'
                                            };
                                        };
                                        componentCall.paramsGenerator_ = paramsLambda;
                                    }
                                    else {
                                        this.updateStateVarsOfChildByElmtId(elmtId, {
                                            kind: StateKind.Error,
                                            title: '加载失败',
                                            description: '网络异常，请稍后重试。',
                                            actionLabel: '重试'
                                        });
                                    }
                                }, { name: "StateView" });
                            }
                        }
                    }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 47, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            content: () => {
                                {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        if (isInitialRender) {
                                            let componentCall = new StateView(this, {
                                                kind: StateKind.Error,
                                                title: '加载失败',
                                                description: '网络异常，请稍后重试。',
                                                actionLabel: '重试'
                                            }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 48, col: 9 });
                                            ViewPU.create(componentCall);
                                            let paramsLambda = () => {
                                                return {
                                                    kind: StateKind.Error,
                                                    title: '加载失败',
                                                    description: '网络异常，请稍后重试。',
                                                    actionLabel: '重试'
                                                };
                                            };
                                            componentCall.paramsGenerator_ = paramsLambda;
                                        }
                                        else {
                                            this.updateStateVarsOfChildByElmtId(elmtId, {
                                                kind: StateKind.Error,
                                                title: '加载失败',
                                                description: '网络异常，请稍后重试。',
                                                actionLabel: '重试'
                                            });
                                        }
                                    }, { name: "StateView" });
                                }
                            }
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "StateCard" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new SectionLabel(this, { text: 'Skeleton · 骨架屏' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 56, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Skeleton · 骨架屏'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Skeleton · 骨架屏'
                    });
                }
            }, { name: "SectionLabel" });
        }
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppCard(this, {
                        content: () => {
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                Row.create();
                                Row.width('100%');
                            }, Row);
                            {
                                this.observeComponentCreation2((elmtId, isInitialRender) => {
                                    if (isInitialRender) {
                                        let componentCall = new Skeleton(this, { blockWidth: 48, blockHeight: 48, radius: Token.radius.full }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 59, col: 11 });
                                        ViewPU.create(componentCall);
                                        let paramsLambda = () => {
                                            return {
                                                blockWidth: 48,
                                                blockHeight: 48,
                                                radius: Token.radius.full
                                            };
                                        };
                                        componentCall.paramsGenerator_ = paramsLambda;
                                    }
                                    else {
                                        this.updateStateVarsOfChildByElmtId(elmtId, {
                                            blockWidth: 48, blockHeight: 48, radius: Token.radius.full
                                        });
                                    }
                                }, { name: "Skeleton" });
                            }
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                Column.create({ space: Token.space.xs });
                                Column.alignItems(HorizontalAlign.Start);
                                Column.layoutWeight(1);
                                Column.margin({ left: Token.space.md });
                            }, Column);
                            {
                                this.observeComponentCreation2((elmtId, isInitialRender) => {
                                    if (isInitialRender) {
                                        let componentCall = new Skeleton(this, { blockWidth: '60%', blockHeight: 16 }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 61, col: 13 });
                                        ViewPU.create(componentCall);
                                        let paramsLambda = () => {
                                            return {
                                                blockWidth: '60%',
                                                blockHeight: 16
                                            };
                                        };
                                        componentCall.paramsGenerator_ = paramsLambda;
                                    }
                                    else {
                                        this.updateStateVarsOfChildByElmtId(elmtId, {
                                            blockWidth: '60%', blockHeight: 16
                                        });
                                    }
                                }, { name: "Skeleton" });
                            }
                            {
                                this.observeComponentCreation2((elmtId, isInitialRender) => {
                                    if (isInitialRender) {
                                        let componentCall = new Skeleton(this, { blockWidth: '90%', blockHeight: 12 }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 62, col: 13 });
                                        ViewPU.create(componentCall);
                                        let paramsLambda = () => {
                                            return {
                                                blockWidth: '90%',
                                                blockHeight: 12
                                            };
                                        };
                                        componentCall.paramsGenerator_ = paramsLambda;
                                    }
                                    else {
                                        this.updateStateVarsOfChildByElmtId(elmtId, {
                                            blockWidth: '90%', blockHeight: 12
                                        });
                                    }
                                }, { name: "Skeleton" });
                            }
                            Column.pop();
                            Row.pop();
                        }
                    }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 57, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            content: () => {
                                this.observeComponentCreation2((elmtId, isInitialRender) => {
                                    Row.create();
                                    Row.width('100%');
                                }, Row);
                                {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        if (isInitialRender) {
                                            let componentCall = new Skeleton(this, { blockWidth: 48, blockHeight: 48, radius: Token.radius.full }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 59, col: 11 });
                                            ViewPU.create(componentCall);
                                            let paramsLambda = () => {
                                                return {
                                                    blockWidth: 48,
                                                    blockHeight: 48,
                                                    radius: Token.radius.full
                                                };
                                            };
                                            componentCall.paramsGenerator_ = paramsLambda;
                                        }
                                        else {
                                            this.updateStateVarsOfChildByElmtId(elmtId, {
                                                blockWidth: 48, blockHeight: 48, radius: Token.radius.full
                                            });
                                        }
                                    }, { name: "Skeleton" });
                                }
                                this.observeComponentCreation2((elmtId, isInitialRender) => {
                                    Column.create({ space: Token.space.xs });
                                    Column.alignItems(HorizontalAlign.Start);
                                    Column.layoutWeight(1);
                                    Column.margin({ left: Token.space.md });
                                }, Column);
                                {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        if (isInitialRender) {
                                            let componentCall = new Skeleton(this, { blockWidth: '60%', blockHeight: 16 }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 61, col: 13 });
                                            ViewPU.create(componentCall);
                                            let paramsLambda = () => {
                                                return {
                                                    blockWidth: '60%',
                                                    blockHeight: 16
                                                };
                                            };
                                            componentCall.paramsGenerator_ = paramsLambda;
                                        }
                                        else {
                                            this.updateStateVarsOfChildByElmtId(elmtId, {
                                                blockWidth: '60%', blockHeight: 16
                                            });
                                        }
                                    }, { name: "Skeleton" });
                                }
                                {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        if (isInitialRender) {
                                            let componentCall = new Skeleton(this, { blockWidth: '90%', blockHeight: 12 }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/StatesSection.ets", line: 62, col: 13 });
                                            ViewPU.create(componentCall);
                                            let paramsLambda = () => {
                                                return {
                                                    blockWidth: '90%',
                                                    blockHeight: 12
                                                };
                                            };
                                            componentCall.paramsGenerator_ = paramsLambda;
                                        }
                                        else {
                                            this.updateStateVarsOfChildByElmtId(elmtId, {
                                                blockWidth: '90%', blockHeight: 12
                                            });
                                        }
                                    }, { name: "Skeleton" });
                                }
                                Column.pop();
                                Row.pop();
                            }
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
            }, { name: "AppCard" });
        }
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
