if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface AppAvatar_Params {
    text?: string;
    avatarSize?: number;
    shape?: AppAvatarShape;
    bgColor?: ResourceColor;
    isDark?: boolean;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
export enum AppAvatarShape {
    Circle = 0,
    Rounded = 1
}
export class AppAvatar extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__text = new SynchedPropertySimpleOneWayPU(params.text, this, "text");
        this.__avatarSize = new SynchedPropertySimpleOneWayPU(params.avatarSize, this, "avatarSize");
        this.__shape = new SynchedPropertySimpleOneWayPU(params.shape, this, "shape");
        this.__bgColor = new SynchedPropertyObjectOneWayPU(params.bgColor, this, "bgColor");
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: AppAvatar_Params) {
        if (params.text === undefined) {
            this.__text.set('');
        }
        if (params.avatarSize === undefined) {
            this.__avatarSize.set(40);
        }
        if (params.shape === undefined) {
            this.__shape.set(AppAvatarShape.Circle);
        }
        if (params.bgColor === undefined) {
            this.__bgColor.set('#2979FF');
        }
    }
    updateStateVars(params: AppAvatar_Params) {
        this.__text.reset(params.text);
        this.__avatarSize.reset(params.avatarSize);
        this.__shape.reset(params.shape);
        this.__bgColor.reset(params.bgColor);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__text.purgeDependencyOnElmtId(rmElmtId);
        this.__avatarSize.purgeDependencyOnElmtId(rmElmtId);
        this.__shape.purgeDependencyOnElmtId(rmElmtId);
        this.__bgColor.purgeDependencyOnElmtId(rmElmtId);
        this.__isDark.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__text.aboutToBeDeleted();
        this.__avatarSize.aboutToBeDeleted();
        this.__shape.aboutToBeDeleted();
        this.__bgColor.aboutToBeDeleted();
        this.__isDark.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __text: SynchedPropertySimpleOneWayPU<string>;
    get text() {
        return this.__text.get();
    }
    set text(newValue: string) {
        this.__text.set(newValue);
    }
    private __avatarSize: SynchedPropertySimpleOneWayPU<number>;
    get avatarSize() {
        return this.__avatarSize.get();
    }
    set avatarSize(newValue: number) {
        this.__avatarSize.set(newValue);
    }
    private __shape: SynchedPropertySimpleOneWayPU<AppAvatarShape>;
    get shape() {
        return this.__shape.get();
    }
    set shape(newValue: AppAvatarShape) {
        this.__shape.set(newValue);
    }
    private __bgColor: SynchedPropertySimpleOneWayPU<ResourceColor>;
    get bgColor() {
        return this.__bgColor.get();
    }
    set bgColor(newValue: ResourceColor) {
        this.__bgColor.set(newValue);
    }
    private __isDark: ObservedPropertyAbstractPU<boolean>;
    get isDark() {
        return this.__isDark.get();
    }
    set isDark(newValue: boolean) {
        this.__isDark.set(newValue);
    }
    private initial(): string {
        return this.text.length > 0 ? this.text.substring(0, 1).toUpperCase() : '?';
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(this.initial());
            Text.fontSize(this.avatarSize * 0.4);
            Text.fontWeight(Token.font.label.weight);
            Text.fontColor(Token.color.onPrimary());
            Text.textAlign(TextAlign.Center);
            Text.width(this.avatarSize);
            Text.height(this.avatarSize);
            Text.backgroundColor(ObservedObject.GetRawObject(this.bgColor));
            Text.borderRadius(this.shape === AppAvatarShape.Circle ? this.avatarSize / 2 : Token.radius.md);
        }, Text);
        Text.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
