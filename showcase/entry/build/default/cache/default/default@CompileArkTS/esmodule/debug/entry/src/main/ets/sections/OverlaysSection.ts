if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface OverlaysSection_Params {
    isDark?: boolean;
    sheetShown?: boolean;
    dialogController?: CustomDialogController;
}
import promptAction from "@ohos:promptAction";
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
import { SectionLabel } from "@bundle:com.riclava.dsshowcase/entry/ets/sections/Widgets";
import { AppDialog } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/components/AppDialog";
import { AppButton, AppButtonType } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/components/AppButton";
export class OverlaysSection extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.__sheetShown = new ObservedPropertySimplePU(false, this, "sheetShown");
        this.dialogController = new CustomDialogController({
            builder: () => {
                let jsDialog = new AppDialog(this, {
                    title: '删除确认',
                    message: '删除后不可恢复，确定继续吗？',
                    confirmLabel: '删除',
                    confirm: () => {
                        promptAction.showToast({ message: '已删除', duration: 2000 });
                    }
                }, undefined, -1, () => { }, { page: "entry/src/main/ets/sections/OverlaysSection.ets", line: 13, col: 14 });
                jsDialog.setController(this.dialogController);
                ViewPU.create(jsDialog);
                let paramsLambda = () => {
                    return {
                        title: '删除确认',
                        message: '删除后不可恢复，确定继续吗？',
                        confirmLabel: '删除',
                        confirm: () => {
                            promptAction.showToast({ message: '已删除', duration: 2000 });
                        }
                    };
                };
                jsDialog.paramsGenerator_ = paramsLambda;
            },
            customStyle: true,
            alignment: DialogAlignment.Center
        }, this);
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: OverlaysSection_Params) {
        if (params.sheetShown !== undefined) {
            this.sheetShown = params.sheetShown;
        }
        if (params.dialogController !== undefined) {
            this.dialogController = params.dialogController;
        }
    }
    updateStateVars(params: OverlaysSection_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__isDark.purgeDependencyOnElmtId(rmElmtId);
        this.__sheetShown.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__isDark.aboutToBeDeleted();
        this.__sheetShown.aboutToBeDeleted();
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
    private __sheetShown: ObservedPropertySimplePU<boolean>;
    get sheetShown() {
        return this.__sheetShown.get();
    }
    set sheetShown(newValue: boolean) {
        this.__sheetShown.set(newValue);
    }
    private dialogController: CustomDialogController;
    sheetContent(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.padding(Token.space.lg);
            Column.alignItems(HorizontalAlign.Center);
            Column.backgroundColor(Token.color.surface());
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 拖拽条
            Row.create();
            // 拖拽条
            Row.width(32);
            // 拖拽条
            Row.height(4);
            // 拖拽条
            Row.backgroundColor(Token.color.outline());
            // 拖拽条
            Row.borderRadius(Token.radius.full);
            // 拖拽条
            Row.margin({ bottom: Token.space.md });
        }, Row);
        // 拖拽条
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('BottomSheet 底部面板');
            Text.fontSize(Token.font.titleLarge.size);
            Text.fontWeight(Token.font.titleLarge.weight);
            Text.fontColor(Token.color.onSurface());
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('顶部圆角 RadiusXL、拖拽条、Level4 阴影，支持下拉关闭。');
            Text.fontSize(Token.font.bodySmall.size);
            Text.fontColor(Token.color.onSurfaceVariant());
            Text.margin({ top: Token.space.xs });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ top: Token.space.lg });
            __Common__.onClick(() => { this.sheetShown = false; });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppButton(this, { label: '关闭', type: AppButtonType.Secondary }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/OverlaysSection.ets", line: 42, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            label: '关闭',
                            type: AppButtonType.Secondary
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        label: '关闭', type: AppButtonType.Secondary
                    });
                }
            }, { name: "AppButton" });
        }
        __Common__.pop();
        Column.pop();
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
                    let componentCall = new SectionLabel(this, { text: 'Overlays · 浮层' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/OverlaysSection.ets", line: 54, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Overlays · 浮层'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Overlays · 浮层'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Flex.create({ wrap: FlexWrap.Wrap });
            Flex.width('100%');
            Flex.bindSheet({ value: this.sheetShown, changeEvent: newValue => { this.sheetShown = newValue; } }, { builder: () => {
                    this.sheetContent.call(this);
                } }, {
                detents: [SheetSize.MEDIUM],
                backgroundColor: Token.color.surface(),
                showClose: false
            });
        }, Flex);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.xs, bottom: Token.space.xs });
            __Common__.onClick(() => { this.dialogController.open(); });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // Dialog
                    AppButton(this, { label: 'Dialog', type: AppButtonType.Primary }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/OverlaysSection.ets", line: 57, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            label: 'Dialog',
                            type: AppButtonType.Primary
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        label: 'Dialog', type: AppButtonType.Primary
                    });
                }
            }, { name: "AppButton" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.xs, bottom: Token.space.xs });
            __Common__.onClick(() => {
                promptAction.showToast({ message: '这是一条轻提示 Toast', duration: 2000 });
            });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // Toast
                    AppButton(this, { label: 'Toast', type: AppButtonType.Secondary }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/OverlaysSection.ets", line: 62, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            label: 'Toast',
                            type: AppButtonType.Secondary
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        label: 'Toast', type: AppButtonType.Secondary
                    });
                }
            }, { name: "AppButton" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.xs, bottom: Token.space.xs });
            __Common__.onClick(() => { this.sheetShown = true; });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // BottomSheet
                    AppButton(this, { label: 'BottomSheet', type: AppButtonType.Secondary }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/OverlaysSection.ets", line: 69, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            label: 'BottomSheet',
                            type: AppButtonType.Secondary
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        label: 'BottomSheet', type: AppButtonType.Secondary
                    });
                }
            }, { name: "AppButton" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Menu
            Text.create('Menu ▾');
            // Menu
            Text.fontSize(Token.font.label.size);
            // Menu
            Text.fontColor(Token.color.primary());
            // Menu
            Text.height(40);
            // Menu
            Text.padding({ left: Token.space.md, right: Token.space.md });
            // Menu
            Text.borderRadius(Token.radius.sm);
            // Menu
            Text.border({ width: 1, color: Token.color.outline() });
            // Menu
            Text.bindMenu([
                { value: '编辑', action: () => promptAction.showToast({ message: '编辑' }) },
                { value: '分享', action: () => promptAction.showToast({ message: '分享' }) },
                { value: '删除', action: () => promptAction.showToast({ message: '删除' }) },
            ]);
        }, Text);
        // Menu
        Text.pop();
        Flex.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
