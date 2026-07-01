if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface ComponentsSection_Params {
    isDark?: boolean;
    switchOn?: boolean;
    sliderVal?: number;
    inputText?: string;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
import { SectionLabel } from "@bundle:com.riclava.dsshowcase/entry/ets/sections/Widgets";
import { AppButton, AppButtonType, AppButtonSize } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/components/AppButton";
import { AppCard } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/components/AppCard";
import { AppTag, AppTagTone } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/components/AppTag";
export class ComponentsSection extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.__switchOn = new ObservedPropertySimplePU(true, this, "switchOn");
        this.__sliderVal = new ObservedPropertySimplePU(40, this, "sliderVal");
        this.__inputText = new ObservedPropertySimplePU('', this, "inputText");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: ComponentsSection_Params) {
        if (params.switchOn !== undefined) {
            this.switchOn = params.switchOn;
        }
        if (params.sliderVal !== undefined) {
            this.sliderVal = params.sliderVal;
        }
        if (params.inputText !== undefined) {
            this.inputText = params.inputText;
        }
    }
    updateStateVars(params: ComponentsSection_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__isDark.purgeDependencyOnElmtId(rmElmtId);
        this.__switchOn.purgeDependencyOnElmtId(rmElmtId);
        this.__sliderVal.purgeDependencyOnElmtId(rmElmtId);
        this.__inputText.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__isDark.aboutToBeDeleted();
        this.__switchOn.aboutToBeDeleted();
        this.__sliderVal.aboutToBeDeleted();
        this.__inputText.aboutToBeDeleted();
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
    private __switchOn: ObservedPropertySimplePU<boolean>;
    get switchOn() {
        return this.__switchOn.get();
    }
    set switchOn(newValue: boolean) {
        this.__switchOn.set(newValue);
    }
    private __sliderVal: ObservedPropertySimplePU<number>;
    get sliderVal() {
        return this.__sliderVal.get();
    }
    set sliderVal(newValue: number) {
        this.__sliderVal.set(newValue);
    }
    private __inputText: ObservedPropertySimplePU<string>;
    get inputText() {
        return this.__inputText.get();
    }
    set inputText(newValue: string) {
        this.__inputText.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.margin({ bottom: Token.space.lg });
        }, Column);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // Buttons
                    SectionLabel(this, { text: 'Button · 按钮' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 17, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Button · 按钮'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Button · 按钮'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Flex.create({ wrap: FlexWrap.Wrap });
            Flex.width('100%');
            Flex.margin({ bottom: Token.space.md });
        }, Flex);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.xs, bottom: Token.space.xs });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppButton(this, { label: 'Primary', type: AppButtonType.Primary }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 19, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            label: 'Primary',
                            type: AppButtonType.Primary
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        label: 'Primary', type: AppButtonType.Primary
                    });
                }
            }, { name: "AppButton" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.xs, bottom: Token.space.xs });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppButton(this, { label: 'Secondary', type: AppButtonType.Secondary }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 21, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            label: 'Secondary',
                            type: AppButtonType.Secondary
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        label: 'Secondary', type: AppButtonType.Secondary
                    });
                }
            }, { name: "AppButton" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.xs, bottom: Token.space.xs });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppButton(this, { label: 'Text', type: AppButtonType.Text }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 23, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            label: 'Text',
                            type: AppButtonType.Text
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        label: 'Text', type: AppButtonType.Text
                    });
                }
            }, { name: "AppButton" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.xs, bottom: Token.space.xs });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppButton(this, { label: 'Danger', type: AppButtonType.Danger }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 25, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            label: 'Danger',
                            type: AppButtonType.Danger
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        label: 'Danger', type: AppButtonType.Danger
                    });
                }
            }, { name: "AppButton" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.xs, bottom: Token.space.xs });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppButton(this, { label: 'Disabled', type: AppButtonType.Primary, disabled: true }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 27, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            label: 'Disabled',
                            type: AppButtonType.Primary,
                            disabled: true
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        label: 'Disabled', type: AppButtonType.Primary, disabled: true
                    });
                }
            }, { name: "AppButton" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.xs, bottom: Token.space.xs });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppButton(this, { label: 'Small', type: AppButtonType.Primary, btnSize: AppButtonSize.Small }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 29, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            label: 'Small',
                            type: AppButtonType.Primary,
                            btnSize: AppButtonSize.Small
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        label: 'Small', type: AppButtonType.Primary, btnSize: AppButtonSize.Small
                    });
                }
            }, { name: "AppButton" });
        }
        __Common__.pop();
        Flex.pop();
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // Tags
                    SectionLabel(this, { text: 'Tag · 标签' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 36, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Tag · 标签'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Tag · 标签'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Flex.create({ wrap: FlexWrap.Wrap });
            Flex.width('100%');
            Flex.margin({ bottom: Token.space.md });
        }, Flex);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.xs, bottom: Token.space.xs });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppTag(this, { label: 'Neutral', tone: AppTagTone.Neutral }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 38, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            label: 'Neutral',
                            tone: AppTagTone.Neutral
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        label: 'Neutral', tone: AppTagTone.Neutral
                    });
                }
            }, { name: "AppTag" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.xs, bottom: Token.space.xs });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppTag(this, { label: 'Primary', tone: AppTagTone.Primary }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 39, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            label: 'Primary',
                            tone: AppTagTone.Primary
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        label: 'Primary', tone: AppTagTone.Primary
                    });
                }
            }, { name: "AppTag" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.xs, bottom: Token.space.xs });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppTag(this, { label: 'Success', tone: AppTagTone.Success }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 40, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            label: 'Success',
                            tone: AppTagTone.Success
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        label: 'Success', tone: AppTagTone.Success
                    });
                }
            }, { name: "AppTag" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.xs, bottom: Token.space.xs });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppTag(this, { label: 'Warning', tone: AppTagTone.Warning }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 41, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            label: 'Warning',
                            tone: AppTagTone.Warning
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        label: 'Warning', tone: AppTagTone.Warning
                    });
                }
            }, { name: "AppTag" });
        }
        __Common__.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            __Common__.create();
            __Common__.margin({ right: Token.space.xs, bottom: Token.space.xs });
        }, __Common__);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppTag(this, { label: 'Danger', tone: AppTagTone.Danger }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 42, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            label: 'Danger',
                            tone: AppTagTone.Danger
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        label: 'Danger', tone: AppTagTone.Danger
                    });
                }
            }, { name: "AppTag" });
        }
        __Common__.pop();
        Flex.pop();
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // Card
                    SectionLabel(this, { text: 'Card · 卡片' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 48, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Card · 卡片'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Card · 卡片'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.margin({ bottom: Token.space.md });
        }, Column);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new AppCard(this, {
                        content: () => {
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                Text.create('卡片标题');
                                Text.fontSize(Token.font.titleMedium.size);
                                Text.fontWeight(Token.font.titleMedium.weight);
                                Text.fontColor(Token.color.onSurface());
                            }, Text);
                            Text.pop();
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                Text.create('使用 Surface 底色、Level1 阴影、RadiusMD 圆角与 MD 内边距。');
                                Text.fontSize(Token.font.bodySmall.size);
                                Text.fontColor(Token.color.onSurfaceVariant());
                                Text.margin({ top: Token.space.xxs });
                            }, Text);
                            Text.pop();
                        }
                    }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 50, col: 9 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            content: () => {
                                this.observeComponentCreation2((elmtId, isInitialRender) => {
                                    Text.create('卡片标题');
                                    Text.fontSize(Token.font.titleMedium.size);
                                    Text.fontWeight(Token.font.titleMedium.weight);
                                    Text.fontColor(Token.color.onSurface());
                                }, Text);
                                Text.pop();
                                this.observeComponentCreation2((elmtId, isInitialRender) => {
                                    Text.create('使用 Surface 底色、Level1 阴影、RadiusMD 圆角与 MD 内边距。');
                                    Text.fontSize(Token.font.bodySmall.size);
                                    Text.fontColor(Token.color.onSurfaceVariant());
                                    Text.margin({ top: Token.space.xxs });
                                }, Text);
                                Text.pop();
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
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // TextField
                    SectionLabel(this, { text: 'TextField · 输入框' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 65, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'TextField · 输入框'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'TextField · 输入框'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TextInput.create({ placeholder: '请输入内容', text: this.inputText });
            TextInput.fontSize(Token.font.body.size);
            TextInput.fontColor(Token.color.onSurface());
            TextInput.placeholderColor(Token.color.onSurfaceVariant());
            TextInput.backgroundColor(Token.color.surface());
            TextInput.height(48);
            TextInput.borderRadius(Token.radius.sm);
            TextInput.border({ width: 1, color: Token.color.outline() });
            TextInput.padding({ left: Token.space.md, right: Token.space.md });
            TextInput.onChange((v: string) => { this.inputText = v; });
            TextInput.margin({ bottom: Token.space.md });
        }, TextInput);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // Switch + Slider + Progress
                    SectionLabel(this, { text: 'Switch · Slider · Progress' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ComponentsSection.ets", line: 79, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Switch · Slider · Progress'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Switch · Slider · Progress'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width('100%');
            Row.margin({ bottom: Token.space.xs });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Toggle.create({ type: ToggleType.Switch, isOn: this.switchOn });
            Toggle.selectedColor(Token.color.primary());
            Toggle.onChange((on: boolean) => { this.switchOn = on; });
        }, Toggle);
        Toggle.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.switchOn ? 'On' : 'Off');
            Text.fontSize(Token.font.bodySmall.size);
            Text.fontColor(Token.color.onSurfaceVariant());
            Text.margin({ left: Token.space.xs });
        }, Text);
        Text.pop();
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Slider.create({ value: this.sliderVal, min: 0, max: 100 });
            Slider.selectedColor(Token.color.primary());
            Slider.trackColor(Token.color.outline());
            Slider.onChange((v: number) => { this.sliderVal = v; });
        }, Slider);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Progress.create({ value: this.sliderVal, total: 100, type: ProgressType.Linear });
            Progress.color(Token.color.primary());
            Progress.backgroundColor(Token.color.outline());
            Progress.margin({ top: Token.space.xs });
        }, Progress);
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
