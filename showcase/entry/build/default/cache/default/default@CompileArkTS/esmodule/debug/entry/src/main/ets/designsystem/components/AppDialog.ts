if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface AppDialog_Params {
    controller?: CustomDialogController;
    title?: string;
    message?: string;
    confirmLabel?: string;
    cancelLabel?: string;
    isDark?: boolean;
    confirm?: () => void;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
export class AppDialog extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.controller = undefined;
        this.__title = new SynchedPropertySimpleOneWayPU(params.title, this, "title");
        this.__message = new SynchedPropertySimpleOneWayPU(params.message, this, "message");
        this.__confirmLabel = new SynchedPropertySimpleOneWayPU(params.confirmLabel, this, "confirmLabel");
        this.__cancelLabel = new SynchedPropertySimpleOneWayPU(params.cancelLabel, this, "cancelLabel");
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.confirm = undefined;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: AppDialog_Params) {
        if (params.controller !== undefined) {
            this.controller = params.controller;
        }
        if (params.title === undefined) {
            this.__title.set('');
        }
        if (params.message === undefined) {
            this.__message.set('');
        }
        if (params.confirmLabel === undefined) {
            this.__confirmLabel.set('确认');
        }
        if (params.cancelLabel === undefined) {
            this.__cancelLabel.set('取消');
        }
        if (params.confirm !== undefined) {
            this.confirm = params.confirm;
        }
    }
    updateStateVars(params: AppDialog_Params) {
        this.__title.reset(params.title);
        this.__message.reset(params.message);
        this.__confirmLabel.reset(params.confirmLabel);
        this.__cancelLabel.reset(params.cancelLabel);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__title.purgeDependencyOnElmtId(rmElmtId);
        this.__message.purgeDependencyOnElmtId(rmElmtId);
        this.__confirmLabel.purgeDependencyOnElmtId(rmElmtId);
        this.__cancelLabel.purgeDependencyOnElmtId(rmElmtId);
        this.__isDark.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__title.aboutToBeDeleted();
        this.__message.aboutToBeDeleted();
        this.__confirmLabel.aboutToBeDeleted();
        this.__cancelLabel.aboutToBeDeleted();
        this.__isDark.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private controller: CustomDialogController;
    setController(ctr: CustomDialogController) {
        this.controller = ctr;
    }
    private __title: SynchedPropertySimpleOneWayPU<string>;
    get title() {
        return this.__title.get();
    }
    set title(newValue: string) {
        this.__title.set(newValue);
    }
    private __message: SynchedPropertySimpleOneWayPU<string>;
    get message() {
        return this.__message.get();
    }
    set message(newValue: string) {
        this.__message.set(newValue);
    }
    private __confirmLabel: SynchedPropertySimpleOneWayPU<string>;
    get confirmLabel() {
        return this.__confirmLabel.get();
    }
    set confirmLabel(newValue: string) {
        this.__confirmLabel.set(newValue);
    }
    private __cancelLabel: SynchedPropertySimpleOneWayPU<string>;
    get cancelLabel() {
        return this.__cancelLabel.get();
    }
    set cancelLabel(newValue: string) {
        this.__cancelLabel.set(newValue);
    }
    private __isDark: ObservedPropertyAbstractPU<boolean>;
    get isDark() {
        return this.__isDark.get();
    }
    set isDark(newValue: boolean) {
        this.__isDark.set(newValue);
    }
    private confirm?: () => void;
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.padding(Token.space.lg);
            Column.backgroundColor(Token.color.surface());
            Column.borderRadius(Token.radius.lg);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.title);
            Text.fontSize(Token.font.titleLarge.size);
            Text.fontWeight(Token.font.titleLarge.weight);
            Text.fontColor(Token.color.onSurface());
            Text.width('100%');
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.message);
            Text.fontSize(Token.font.body.size);
            Text.fontColor(Token.color.onSurfaceVariant());
            Text.width('100%');
            Text.margin({ top: Token.space.sm });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width('100%');
            Row.justifyContent(FlexAlign.End);
            Row.margin({ top: Token.space.lg });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.cancelLabel);
            Text.fontSize(Token.font.label.size);
            Text.fontColor(Token.color.onSurfaceVariant());
            Text.height(40);
            Text.padding({ left: Token.space.md, right: Token.space.md });
            Text.onClick(() => { this.controller.close(); });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.confirmLabel);
            Text.fontSize(Token.font.label.size);
            Text.fontColor(Token.color.onPrimary());
            Text.height(40);
            Text.padding({ left: Token.space.lg, right: Token.space.lg });
            Text.backgroundColor(Token.color.primary());
            Text.borderRadius(Token.radius.sm);
            Text.margin({ left: Token.space.sm });
            Text.onClick(() => {
                if (this.confirm)
                    this.confirm();
                this.controller.close();
            });
        }, Text);
        Text.pop();
        Row.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
