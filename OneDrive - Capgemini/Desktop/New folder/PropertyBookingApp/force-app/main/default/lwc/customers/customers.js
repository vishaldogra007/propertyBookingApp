import { LightningElement ,wire} from 'lwc';
import allcustomers from '@salesforce/apex/CustomerClass.allCustomers';

export default class Customers extends LightningElement {

customers;

@wire(allcustomers)
   getCustomers({data,error}){
    if(data){
        this.customers = data;
    }else{
        console.log(error);
    }
   }

}