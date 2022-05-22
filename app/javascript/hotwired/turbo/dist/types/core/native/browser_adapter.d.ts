import { Adapter } from "./adapter";
import { ProgressBar } from "../drive/progress_bar";
import { Visit, VisitOptions } from "../drive/visit";
import { FormSubmission } from "../drive/form_submission";
import { Session } from "../session";
export declare class BrowserAdapter implements Adapter {
    readonly session: Session;
    readonly progressBar: ProgressBar;
    visitProgressBarTimeout?: number;
    formProgressBarTimeout?: number;
    constructor(session: Session);
    visitProposedToLocation(location: URL, options?: Partial<VisitOptions>): void;
    visitStarted(visit: Visit): void;
    visitRequestStarted(visit: Visit): void;
    visitRequestCompleted(visit: Visit): void;
    visitRequestFailedWithStatusCode(visit: Visit, statusCode: number): void;
    visitRequestFinished(visit: Visit): void;
    visitCompleted(visit: Visit): void;
    pageInvalidated(): void;
    visitFailed(visit: Visit): void;
    visitRendered(visit: Visit): void;
    formSubmissionStarted(formSubmission: FormSubmission): void;
    formSubmissionFinished(formSubmission: FormSubmission): void;
    showVisitProgressBarAfterDelay(): void;
    hideVisitProgressBar(): void;
    showFormProgressBarAfterDelay(): void;
    hideFormProgressBar(): void;
    showProgressBar: () => void;
    reload(): void;
    get navigator(): import("../drive/navigator").Navigator;
}