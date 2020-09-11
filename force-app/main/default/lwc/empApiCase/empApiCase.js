import { LightningElement } from 'lwc';
import { subscribe, unsubscribe, onError, setDebugFlag, isEmpEnabled } from 'lightning/empApi';

export default class EmpApiCase extends LightningElement {
    casesEventChannel = 'event/CaseEvent__e';
    isSubscribeDisabled = false;
    isUnsubscribeDisabled = !this.isSubscribeDisabled;

    subscription = {};


    handleCasesEventChannel(event) {
        this.casesEventChannel = event.target.value;
    }

    connectedCallBack() {
        this.registerErrorListener();
    }

    handleSubscribe() {
        const messageCallback = function(response){
            console.log('New message received: ', JSON.stringify(response));
        };

        subscribe(this.casesEventChannel, -1, messageCallback).then(response => {
            // Response contains the subscription information on subscribe call
            console.log('Subscription request sent to: ', JSON.stringify(response.channel));
            this.subscription = response;
            this.toggleSubscribeButton(true);
        });
    }

    handleUnsubscribe() {
        this.toggleSubscribeButton(false);
        unsubscribe(this.subscription, response => {
            console.log('unsubscribe() response: ', JSON.stringify(response));
        });
    }

    toggleSubscribeButton(enableSubscribe){
        this.isSubscribeDisabled = enableSubscribe;
        this.isUnsubscribeDisabled = !enableSubscribe;
    }

    registerErrorListener(){
        onError(error => {
            console.log('Received error from server: ', JSON.stringify(error));
        });
    }
}