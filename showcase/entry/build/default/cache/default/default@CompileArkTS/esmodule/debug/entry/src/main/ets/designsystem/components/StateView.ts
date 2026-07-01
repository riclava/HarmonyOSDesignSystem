if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface StateView_Params {
    kind?: StateKind;
    title?: string;
    description?: string;
    actionLabel?: string;
    isDark?: boolean;
    onAction?: () => void;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
export enum StateKind {
    Loading = 0,
    Empty = 1,
    Error = 2
}
export class StateView extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__kind = new SynchedPropertySimpleOneWayPU(params.kind, this, "kind");
        this.__title = new SynchedPropertySimpleOneWayPU(params.title, this, "title");
        this.__description = new SynchedPropertySimpleOneWayPU(params.description, this, "description");
        this.__actionLabel = new SynchedPropertySimpleOneWayPU(params.actionLabel, this, "actionLabel");
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.onAction = undefined;
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: StateView_Params) {
        if (params.kind === undefined) {
            this.__kind.set(StateKind.Empty);
        }
        if (params.title === undefined) {
            this.__title.set('');
        }
        if (params.description === undefined) {
            this.__description.set('');
        }
        if (params.actionLabel === undefined) {
            this.__actionLabel.set('');
        }
        if (params.onAction !== undefined) {
            this.onAction = params.onAction;
        }
    }
    updateStateVars(params: StateView_Params) {
        this.__kind.reset(params.kind);
        this.__title.reset(params.title);
        this.__description.reset(params.description);
        this.__actionLabel.reset(params.actionLabel);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__kind.purgeDependencyOnElmtId(rmElmtId);
        this.__title.purgeDependencyOnElmtId(rmElmtId);
        this.__description.purgeDependencyOnElmtId(rmElmtId);
        this.__actionLabel.purgeDependencyOnElmtId(rmElmtId);
        this.__isDark.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__kind.aboutToBeDeleted();
        this.__title.aboutToBeDeleted();
        this.__description.aboutToBeDeleted();
        this.__actionLabel.aboutToBeDeleted();
        this.__isDark.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __kind: SynchedPropertySimpleOneWayPU<StateKind>;
    get kind() {
        return this.__kind.get();
    }
    set kind(newValue: StateKind) {
        this.__kind.set(newValue);
    }
    private __title: SynchedPropertySimpleOneWayPU<string>;
    get title() {
        return this.__title.get();
    }
    set title(newValue: string) {
        this.__title.set(newValue);
    }
    private __description: SynchedPropertySimpleOneWayPU<string>;
    get description() {
        return this.__description.get();
    }
    set description(newValue: string) {
        this.__description.set(newValue);
    }
    private __actionLabel: SynchedPropertySimpleOneWayPU<string>;
    get actionLabel() {
        return this.__actionLabel.get();
    }
    set actionLabel(newValue: string) {
        this.__actionLabel.set(newValue);
    }
    private __isDark: ObservedPropertyAbstractPU<boolean>;
    get isDark() {
        return this.__isDark.get();
    }
    set isDark(newValue: boolean) {
        this.__isDark.set(newValue);
    }
    private onAction?: () => void;
    private glyph(): string {
        switch (this.kind) {
            case StateKind.Loading: return '⏳';
            case StateKind.Error: return '⚠️';
            default: return '📭';
        }
    }
    private iconColor(): ResourceColor {
        return this.kind === StateKind.Error ? Token.color.danger() : Token.color.onSurfaceVariant();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.padding(Token.space.xl);
            Column.justifyContent(FlexAlign.Center);
            Column.alignItems(HorizontalAlign.Center);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.kind === StateKind.Loading) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        LoadingProgress.create();
                        LoadingProgress.width(Token.icon.xxl);
                        LoadingProgress.height(Token.icon.xxl);
                        LoadingProgress.color(Token.color.primary());
                    }, LoadingProgress);
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create(this.glyph());
                        Text.fontSize(Token.icon.xxl);
                        Text.fontColor(this.iconColor());
                    }, Text);
                    Text.pop();
                });
            }
        }, If);
        If.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.title);
            Text.fontSize(Token.font.titleMedium.size);
            Text.fontWeight(Token.font.titleMedium.weight);
            Text.fontColor(Token.color.onSurface());
            Text.margin({ top: Token.space.sm });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.description.length > 0) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create(this.description);
                        Text.fontSize(Token.font.bodySmall.size);
                        Text.fontColor(Token.color.onSurfaceVariant());
                        Text.textAlign(TextAlign.Center);
                        Text.margin({ top: Token.space.xxs });
                    }, Text);
                    Text.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.actionLabel.length > 0) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create(this.actionLabel);
                        Text.fontSize(Token.font.label.size);
                        Text.fontColor(Token.color.onPrimary());
                        Text.height(40);
                        Text.padding({ left: Token.space.lg, right: Token.space.lg });
                        Text.backgroundColor(Token.color.primary());
                        Text.borderRadius(Token.radius.sm);
                        Text.margin({ top: Token.space.md });
                        Text.onClick(() => { if (this.onAction)
                            this.onAction(); });
                    }, Text);
                    Text.pop();
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                });
            }
        }, If);
        If.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
