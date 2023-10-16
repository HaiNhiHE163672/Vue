<template>
  <v-app>
    <v-app-bar app color="red">
      <v-container>
        <div class="wrapper-heading">
          <button @click="LoadHome"><h2>SenDo</h2></button>
          <div class="wrapper-search">
            <v-menu>
              <template v-slot:activator="{ props }">
                <v-btn v-bind="props" icon>
                  <v-icon>mdi-view-dashboard</v-icon>
                </v-btn>
              </template>
              <v-list>
                <v-list-item
                  v-for="(item, i) in productTypes"
                  :key="i"
                  value="item.productTypeId"
                  @click="sortType(item.productTypeId)"
                >
                  <router-link
                    :to="{
                      path: `/`,
                      query: { productTypeId: item.productTypeId },
                    }"
                    style="text-decoration: none; color: black"
                  >
                    <v-list-item-title>{{
                      item.productTypeName
                    }}</v-list-item-title>
                  </router-link>
                </v-list-item>
              </v-list>
            </v-menu>

            <input
              v-model="$route.query.search"
              type="search"
              class="input-search"
              placeholder="Tìm trên SenDo"
            />
            <v-btn class="btn-search" icon>
              <v-icon
                style="width: 20; height: 20"
                @click="searchProduct($route.query.search)"
                >mdi-magnify</v-icon
              >
            </v-btn>
          </div>
          <div class="wrapper-avatar">
            <v-btn icon>
              <v-badge
                v-if="cartQuantity > 0"
                :content="cartQuantity"
                color="error"
              >
                <router-link
                  :to="{
                    path: `/cart`,
                  }"
                >
                  <v-icon style="color: white">mdi-shopping</v-icon>
                </router-link>
              </v-badge>
            </v-btn>

            <div class="avatar-img">
              <v-avatar size="x-small">
                <v-img
                  src="https://cdn.vuetifyjs.com/images/john.jpg"
                  alt="John"
                ></v-img>
              </v-avatar>
              <span style="margin: 5px">John</span>
            </div>
          </div>
        </div>
      </v-container>
    </v-app-bar>
    <v-main>
      <div>
        <div class="wrapper-card">
          <div
            v-for="(item, index) in displayProducts"
            :key="index"
            value="item"
            class="card-product"
          >
            <v-card width="300" style="height: 100%">
              <v-img :src="item.avartarImage"></v-img>
              <v-card-title>{{ item.productName }}</v-card-title>
              <v-card-text>
                <p v-if="item.discount > 0" style="color: gray">
                  <i
                    ><del>{{ item.price / 1000 }}.000đ </del></i
                  >
                  <span style="color: red; margin: 0 5px"
                    >{{ item.discount }}%</span
                  >
                </p>
                <h3 style="color: red">
                  {{
                    Math.ceil((item.price * (100 - item.discount)) / 100000)
                  }}.000đ
                </h3>
              </v-card-text>
              <v-card-actions>
                <router-link
                  :to="{
                    path: `/detail/${item.productId}`,
                    state: { displayProducts },
                    params: {
                      id: item.productId,
                      item: item,
                    },
                  }"
                >
                  <v-btn>Mua Ngay</v-btn></router-link
                >

                <v-spacer></v-spacer>
                <v-card-subtitle>{{ item.shop.shopAddress }}</v-card-subtitle>
              </v-card-actions>
            </v-card>
          </div>
        </div>
        <v-pagination
          v-if="products.length > 0"
          v-model="pageNumber"
          :length="totalPage"
          @click="changePage(pageNumber)"
          rounded="circle"
        ></v-pagination>
      </div>
    </v-main>
  </v-app>
</template>

<script>
import axios from "axios";

export default {
  name: "HelloWorld",
  data() {
    return {
      productTypes: [],
      products: [],
      pageNumber: 1,
      pageSize: 9,
      totalPage: null,
      // search: "",
      isSort: false,
      productTypeId: 0,
      cartQuantity: 0,
      typeId: 1,
    };
  },
  created() {
    this.getProductTypes();
    if (this.$route.query.search !== undefined) {
      this.searchProducts(this.pageSize, 1, this.$route.query.search);
    } else if (this.$route.query.productTypeId !== undefined) {
      this.sortProductType(this.pageSize, 1, this.$route.query.productTypeId);
    } else {
      this.getProducts(this.pageSize, 1);
    }

    this.CartNumber();
  },
  computed: {
    displayProducts() {
      if (this.isSort === true) {
        return this.products.filter(
          (x) => x.productType.productTypeId === this.productTypeId
        );
      } else {
        return this.products;
      }
    },
  },
  methods: {
    LoadHome() {
      this.isSort = false;
      this.getProducts(this.pageSize, 1);
      this.$router.push({ path: this.$route.path });
    },
    sortType(id) {
      this.isSort = true;
      this.productTypeId = id;
      this.sortProductType(this.pageSize, 1, this.productTypeId);
    },
    searchProduct(search) {
      this.isSort = false;
      this.$route.query.search = search;
      this.searchProducts(this.pageSize, 1, this.$route.query.search);
    },
    changePage(page) {
      this.pageNumber = page;
      if (this.$route.query.search === undefined) {
        this.getProducts(this.pageSize, this.pageNumber);
      } else {
        this.searchProducts(
          this.pageSize,
          this.pageNumber,
          this.$route.query.search
        );
      }
    },
    getProductTypes() {
      axios
        .get("https://localhost:7107/api/Product/ListProductType")
        .then((response) => {
          // console.log(response.data);
          this.productTypes = response.data;
        });
    },
    getProducts(pageSize, pageNumber) {
      axios
        .get(
          `https://localhost:7107/api/Product?PageSize=${pageSize}&PageNumber=${pageNumber}`
        )
        .then((response) => {
          console.log(response.data.data);
          this.products = response.data.data;
          this.totalPage = response.data.pagination.totalPage;
        });
    },
    searchProducts(pageSize, pageNumber, search) {
      axios
        .get(
          `https://localhost:7107/api/Product?PageSize=${pageSize}&PageNumber=${pageNumber}&search=${search}`
        )
        .then((response) => {
          console.log(response.data.data);
          this.products = response.data.data;
          this.totalPage = response.data.pagination.totalPage;
        });
    },
    sortProductType(pageSize, pageNumber, typeId) {
      axios
        .get(
          `https://localhost:7107/api/Product?PageSize=${pageSize}&PageNumber=${pageNumber}&typeId=${typeId}`
        )
        .then((response) => {
          console.log(response.data.data);
          this.products = response.data.data;
          this.totalPage = response.data.pagination.totalPage;
        });
    },
    CartNumber() {
      axios
        .get("https://localhost:7107/api/Product/QuantityCart")
        .then((response) => {
          this.cartQuantity = response.data;
        });
    },
  },
};
</script>
<style scoped>
.wrapper-heading {
  align-items: center;
  display: flex;
  height: 6.4rem;
}
.nav-heading {
  position: fixed;
  top: 0;
}
.wrapper-search {
  display: flex;
  flex-grow: 2;
}
.input-search {
  background-color: white;
  color: gray;
  outline: 0;
  padding: 12px;
  border-radius: 5px;
  width: 100%;
}
.btn-search {
  background-color: #fff;
  /* border: 5px solid #fff; */
  color: #3f4b53;
  border-radius: 5px;
  margin: 0 3px;
  box-sizing: border-box;
  padding: 0;
}
.wrapper-avatar {
  display: flex;
  justify-content: center;
  width: 200px;
  height: 50px;
}

.avatar-img {
  align-items: center;
  background-color: #fff;
  border-radius: 20px;
  cursor: pointer;
  display: flex;
  position: relative;
  color: #3f4b53;
  justify-content: space-around;
  margin: 12px;
}
.wrapper-card {
  display: flex;
  gap: 30px;
  flex-wrap: wrap;
  justify-content: center;
  padding: 60px 0;
}
.card-product {
  flex-basis: 25%;
}
</style>
