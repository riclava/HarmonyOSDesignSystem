if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface FormSection_Params {
    isDark?: boolean;
    search?: string;
    agree?: boolean;
    plan?: string;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
import { SectionLabel } from "@bundle:com.riclava.dsshowcase/entry/ets/sections/Widgets";
export class FormSection extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.__search = new ObservedPropertySimplePU('', this, "search");
        this.__agree = new ObservedPropertySimplePU(true, this, "agree");
        this.__plan = new ObservedPropertySimplePU('monthly', this, "plan");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: FormSection_Params) {
        if (params.search !== undefined) {
            this.search = params.search;
        }
        if (params.agree !== undefined) {
            this.agree = params.agree;
        }
        if (params.plan !== undefined) {
            this.plan = params.plan;
        }
    }
    updateStateVars(params: FormSection_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__isDark.purgeDependencyOnElmtId(rmElmtId);
        this.__search.purgeDependencyOnElmtId(rmElmtId);
        this.__agree.purgeDependencyOnElmtId(rmElmtId);
        this.__plan.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__isDark.aboutToBeDeleted();
        this.__search.aboutToBeDeleted();
        this.__agree.aboutToBeDeleted();
        this.__plan.aboutToBeDeleted();
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
    private __search: ObservedPropertySimplePU<string>;
    get search() {
        return this.__search.get();
    }
    set search(newValue: string) {
        this.__search.set(newValue);
    }
    private __agree: ObservedPropertySimplePU<boolean>;
    get agree() {
        return this.__agree.get();
    }
    set agree(newValue: boolean) {
        this.__agree.set(newValue);
    }
    private __plan: ObservedPropertySimplePU<string>;
    get plan() {
        return this.__plan.get();
    }
    set plan(newValue: string) {
        this.__plan.set(newValue);
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
                    // Search
                    SectionLabel(this, { text: 'Search · 搜索框' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/FormSection.ets", line: 14, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Search · 搜索框'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Search · 搜索框'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width('100%');
            Row.height(40);
            Row.padding({ left: Token.space.md, right: Token.space.md });
            Row.backgroundColor(Token.color.surface());
            Row.borderRadius(Token.radius.full);
            Row.border({ width: 1, color: Token.color.outline() });
            Row.margin({ bottom: Token.space.md });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('🔍');
            Text.fontSize(Token.font.bodySmall.size);
            Text.margin({ right: Token.space.xs });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TextInput.create({ placeholder: '搜索…', text: this.search });
            TextInput.fontSize(Token.font.body.size);
            TextInput.fontColor(Token.color.onSurface());
            TextInput.placeholderColor(Token.color.onSurfaceVariant());
            TextInput.backgroundColor(Token.color.transparent());
            TextInput.borderRadius(0);
            TextInput.padding(0);
            TextInput.layoutWeight(1);
            TextInput.onChange((v: string) => { this.search = v; });
        }, TextInput);
        Row.pop();
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // Checkbox
                    SectionLabel(this, { text: 'Checkbox · 复选框' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/FormSection.ets", line: 38, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Checkbox · 复选框'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Checkbox · 复选框'
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
            Checkbox.create();
            Checkbox.select(this.agree);
            Checkbox.selectedColor(Token.color.primary());
            Checkbox.onChange((v: boolean) => { this.agree = v; });
        }, Checkbox);
        Checkbox.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('我已阅读并同意用户协议');
            Text.fontSize(Token.font.body.size);
            Text.fontColor(Token.color.onSurface());
            Text.margin({ left: Token.space.xs });
        }, Text);
        Text.pop();
        Row.pop();
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new 
                    // Radio group
                    SectionLabel(this, { text: 'Radio · 单选框' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/FormSection.ets", line: 53, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Radio · 单选框'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Radio · 单选框'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width('100%');
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Radio.create({ value: 'monthly', group: 'plan' });
            Radio.checked(this.plan === 'monthly');
            Radio.radioStyle({ checkedBackgroundColor: Token.color.primary() });
            Radio.onChange((c: boolean) => { if (c)
                this.plan = 'monthly'; });
        }, Radio);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('按月');
            Text.fontSize(Token.font.body.size);
            Text.fontColor(Token.color.onSurface());
            Text.margin({ right: Token.space.lg, left: Token.space.xxs });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Radio.create({ value: 'yearly', group: 'plan' });
            Radio.checked(this.plan === 'yearly');
            Radio.radioStyle({ checkedBackgroundColor: Token.color.primary() });
            Radio.onChange((c: boolean) => { if (c)
                this.plan = 'yearly'; });
        }, Radio);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('按年');
            Text.fontSize(Token.font.body.size);
            Text.fontColor(Token.color.onSurface());
            Text.margin({ left: Token.space.xxs });
        }, Text);
        Text.pop();
        Row.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
