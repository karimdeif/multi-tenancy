<template>
  <div>
  <div style="display: flex;flex-direction: row;">
    <div id="app" style="order: 1;flex-grow: 2;max-width: 300px;width:300px">
    <!-- Headerline -->
    <mwc-top-app-bar-fixed>
       <!-- <div slot="title">Electronic and Movie Depot <md-icon class="md-size-x">verified_user</md-icon></div> -->  
       
       <div slot="title">
        <md-menu md-size="big">
            <md-button md-size="big" md-menu-trigger style="color:white;">{{ headline }}</md-button>
        </md-menu>
        
        <md-menu md-size="small" v-if="isAuthenticated == true">
            <md-button md-size="small" md-menu-trigger style="color:white;">{{ getUserName() }}<md-icon class="md-size-x">verified_user</md-icon></md-button>
            <md-menu-content>
              <md-menu-item v-on:click="onCheckTokenClicked()">Check token</md-menu-item>
              <md-menu-item v-on:click="onLogoutClicked()">Logout</md-menu-item>
            </md-menu-content>
        </md-menu>
    
       </div>
              
    </mwc-top-app-bar-fixed>
    
    <!-- Content -->
    <md-app>
      <md-app-drawer md-permanent="full" style="width: 240px;">
        <br>
        <md-list v-if="isAuthenticated == true">
          <md-list-item to="/catalog" exact>
            <md-icon style="margin-right: 10px;">explore</md-icon>
            <span class="md-list-item-text">Catalog</span>
          </md-list-item>

          <div
            v-for="category in this.categories"
            :key="category.name"
            class=""
          >
          <md-list-item style="margin-left:50px">
            <span class="md-list-item-text">{{ category.name }}</span>
          </md-list-item>
            <div
              style="padding-left: 50px"
              v-for="subCategory in category.subCategories"
              :key="subCategory.id"
              class=""
            >
              <md-list-item @click="loadProducts(subCategory.id, subCategory.name)" style="padding-left:0px" exact>
                <md-icon style="margin-right: 10px;">explore</md-icon>
                <span class="md-list-item-text">{{ subCategory.name }}</span>
              </md-list-item>
            </div>
          </div>

          <md-list-item to="/order" exact
            ><md-icon style="margin-right: 10px;">add_shopping_cart</md-icon>
            <span class="md-list-item-text"
              >Shopping Cart ({{ amountLineItems }})</span
            >
          </md-list-item>
          <md-list-item to="/account" exact>
            <md-icon style="margin-right: 10px;">settings</md-icon>
            <span class="md-list-item-text">Account</span>
          </md-list-item>
        </md-list>
      </md-app-drawer>
    </md-app>
    </div>
    <div id="catalog" style="order: 2; flex-grow: 10;left: 320px;position: fixed;" v-if="isAuthenticated == true">
    <Catalog></Catalog>
    </div>
    <div id="order" style="order: 2; flex-grow: 10;left: 320px;position: fixed;" v-if="isAuthenticated == true"></div>
    <div id="account" style="order: 2; flex-grow: 10;left: 320px;position: fixed;"></div>
  </div>
  </div>
</template>

<script>
import Messaging from "./messaging.js";
import Catalog from "./Catalog.vue";
import "@material/mwc-top-app-bar-fixed";
import axios from "axios";

export default {
  name: "app",
  components: {
    Catalog
  },
  computed: {
    isAuthenticated() {
      return this.$store.state.user.isAuthenticated;
    }
  },
  data() {
    return {
      categories: {},
      loadingCategories: false,
      amountLineItems: 0,
      apiUrlCategories: window.VUE_APP_API_URL_CATEGORIES,
      apiUrlOrders: window.VUE_APP_API_URL_ORDERS,
      headline: window.VUE_APP_HEADLINE
    };
  },
  created() {
    this.readCategories();

    let observable = Messaging.getObservable(
      Messaging.MICRO_FRONTEND_NAVIGATOR
    );
    observable.subscribe({
      next: (message) => {
        console.log(
          "navigator - App.vue - amountLineItems: " +
            message.payload.amountLineItems
        );
        this.amountLineItems = message.payload.amountLineItems;
      },
    });

    fetch(this.apiUrlOrders)
      .then((response) => response.json())
      .then((json) => {
        this.amountLineItems = 0;
        if (json[0]) {
          json[0].lineitems.forEach((lineItem) => {
            this.amountLineItems = this.amountLineItems + lineItem.quantity;
          });
        }
      })
      .catch((error) => {
        console.error(error);
      });
  },
  methods: {
    onCheckTokenClicked(){
      const axiosService = axios.create({
      timeout: 30000, // because of Code Engine response can be up to 18,29 sec in Postman
      headers: {
          "Content-Type": "application/json",
          Authorization: "Bearer " + this.$store.state.user.accessToken
        }
      });
      let that = this;
      let url = "http://localhost:8084/articlesA";
      console.log("--> log: readArticles URL : " + url);
      axiosService
        .get(url)
        .then(function(response) {
          that.articles = response.data;
          console.log("--> log: readArticles data : " + that.articles);
          that.loading = false;
          that.error = "";
        })
        .catch(function(error) {
          console.log("--> log: readArticles error: " + error);
          that.loading = false;
          that.error = error;
        });      
    },
    onLogoutClicked(){
      this.$store.commit("logout");
    },
    getUserName() {
      return this.$store.state.user.name;
    },
    loadProducts (categoryId, categoryName) {
      let commandId = Date.now();
      let message = {
        topic: Messaging.TOPIC_NAVIGATOR_CATEGORY_CHANGED,
        commandId: commandId,
        payload: {
          categoryId: categoryId,
          categoryName: categoryName
        },
      };
      Messaging.send(message);
      this.$router.push('/catalog').catch()
    },
    readCategories() {
      if (this.loadingCategories == false) {
        this.loadingCategories = true;
        fetch(this.apiUrlCategories)
          .then((r) => r.json())
          .then((json) => {
            this.loadingCategories = false;
            this.categories = json;
          })
          .catch((error) => {
            this.loadingCategories = false;
            console.error(error);
          });
      }
    },
  },
};
</script>
