import { LightningElement } from 'lwc';
import { subscribe, unsubscribe, onError, setDebugFlag, isEmpEnabled } from 'lightning/empApi';

export default class EmpApiCase extends LightningElement {
    casesEventChannel = 'event/CaseEvent__e';
    isSubscribeDisabled = false;
    isUnsubscribeDisabled = !this.isSubscribeDisabled;
    payload;

    subscription = {};


    handleCasesEventChannel(event) {
        this.casesEventChannel = event.target.value;
    }

    connectedCallBack() {
        console.log('NIE MA');
        this.registerErrorListener();
    }

    handleSubscribe() {
        const messageCallback = (response) => {
            console.log('New message received : ', JSON.stringify(response));
            this.payload = JSON.stringify(response);
            console.log('this.payload: ' + this.payload);
            // Response contains the payload of the new message received
        };

        subscribe(this.casesEventChannel, -1, messageCallback).then(response => {
            // Response contains the subscription information on subscribe call
            console.log('Subscription request sent to: ', response);
            this.subscription = response;
            console.log(this.subscription);
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