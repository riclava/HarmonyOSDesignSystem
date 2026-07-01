if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface AdaptiveSection_Params {
    isDark?: boolean;
    breakpoint?: string;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
import { SectionLabel } from "@bundle:com.riclava.dsshowcase/entry/ets/sections/Widgets";
export class AdaptiveSection extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.__breakpoint = new ObservedPropertySimplePU('sm', this, "breakpoint");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: AdaptiveSection_Params) {
        if (params.breakpoint !== undefined) {
            this.breakpoint = params.breakpoint;
        }
    }
    updateStateVars(params: AdaptiveSection_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__isDark.purgeDependencyOnElmtId(rmElmtId);
        this.__breakpoint.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__isDark.aboutToBeDeleted();
        this.__breakpoint.aboutToBeDeleted();
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
    private __breakpoint: ObservedPropertySimplePU<string>;
    get breakpoint() {
        return this.__breakpoint.get();
    }
    set breakpoint(newValue: string) {
        this.__breakpoint.set(newValue);
    }
    cell(label: string, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.justifyContent(FlexAlign.Center);
            Column.alignItems(HorizontalAlign.Center);
            Column.height(56);
            Column.width('100%');
            Column.backgroundColor(Token.color.primary());
            Column.borderRadius(Token.radius.sm);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(label);
            Text.fontSize(Token.font.label.size);
            Text.fontColor(Token.color.onPrimary());
        }, Text);
        Text.pop();
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
                    let componentCall = new SectionLabel(this, { text: 'Adaptive · 自适应栅格' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/AdaptiveSection.ets", line: 26, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Adaptive · 自适应栅格'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Adaptive · 自适应栅格'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(`当前断点：${this.breakpoint}（改变窗口/设备宽度可观察列数变化）`);
            Text.fontSize(Token.font.caption.size);
            Text.fontColor(Token.color.onSurfaceVariant());
            Text.margin({ bottom: Token.space.sm });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 断点：<600 单列，600~840 两列，>840 三列
            GridRow.create({
                columns: { sm: 4, md: 8, lg: 12 },
                gutter: { x: Token.space.sm, y: Token.space.sm },
                breakpoints: { value: ['600vp', '840vp'], reference: BreakpointsReference.WindowSize }
            });
            // 断点：<600 单列，600~840 两列，>840 三列
            GridRow.width('100%');
            // 断点：<600 单列，600~840 两列，>840 三列
            GridRow.onBreakpointChange((bp: string) => { this.breakpoint = bp; });
        }, GridRow);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    GridCol.create({ span: { sm: 4, md: 4, lg: 4 } });
                }, GridCol);
                this.cell.bind(this)(`Item ${item}`);
                GridCol.pop();
            };
            this.forEachUpdateFunction(elmtId, ['1', '2', '3'], forEachItemGenFunction);
        }, ForEach);
        ForEach.pop();
        // 断点：<600 单列，600~840 两列，>840 三列
        GridRow.pop();
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new SectionLabel(this, { text: 'Accessibility · 无障碍' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/AdaptiveSection.ets", line: 47, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Accessibility · 无障碍'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Accessibility · 无障碍'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 触摸区域：视觉 24，命中 ≥ 44
            Row.create();
            // 触摸区域：视觉 24，命中 ≥ 44
            Row.width('100%');
            // 触摸区域：视觉 24，命中 ≥ 44
            Row.margin({ top: Token.space.xs });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create();
            Stack.width(44);
            Stack.height(44);
            Stack.backgroundColor(Token.color.primaryContainer());
            Stack.borderRadius(Token.radius.sm);
            Stack.accessibilityText('更多操作');
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Circle.create({ width: 24, height: 24 });
            Circle.fill(Token.color.primary());
        }, Circle);
        Stack.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.alignItems(HorizontalAlign.Start);
            Column.layoutWeight(1);
            Column.margin({ left: Token.space.md });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('触摸命中区 ≥ 44×44vp');
            Text.fontSize(Token.font.body.size);
            Text.fontColor(Token.color.onSurface());
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('图标视觉 24，外围命中区 44（浅底示意）。图标按钮需带语义 Label。');
            Text.fontSize(Token.font.caption.size);
            Text.fontColor(Token.color.onSurfaceVariant());
        }, Text);
        Text.pop();
        Column.pop();
        // 触摸区域：视觉 24，命中 ≥ 44
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 对比度示例
            Row.create();
            // 对比度示例
            Row.width('100%');
            // 对比度示例
            Row.margin({ top: Token.space.md });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('正文 4.5:1');
            Text.fontSize(Token.font.body.size);
            Text.fontColor(Token.color.onSurface());
            Text.backgroundColor(Token.color.surface());
            Text.padding(Token.space.xs);
            Text.borderRadius(Token.radius.xs);
            Text.margin({ right: Token.space.xs });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('主色按钮');
            Text.fontSize(Token.font.body.size);
            Text.fontColor(Token.color.onPrimary());
            Text.backgroundColor(Token.color.primary());
            Text.padding(Token.space.xs);
            Text.borderRadius(Token.radius.xs);
        }, Text);
        Text.pop();
        // 对比度示例
        Row.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
