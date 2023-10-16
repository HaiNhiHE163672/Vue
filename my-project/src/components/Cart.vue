<template>
  <v-app>
    <v-app-bar app color="red">
      <v-container class="wrapper-heading">
        <router-link
          :to="{
            path: `/`,
          }"
          style="text-decoration: none; color: white"
          ><h2>SenDo</h2></router-link
        >
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
                value="item"
                @click="sortType(item.productTypeId)"
              >
                <v-list-item-title>{{
                  item.productTypeName
                }}</v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>

          <input
            v-model="search"
            type="search"
            class="input-search"
            placeholder="Tìm trên SenDo"
          />
          <router-link
            :to="{
              path: `/`,
              query: { search: search },
            }"
            style="text-decoration: none; color: white"
          >
            <v-btn class="btn-search" icon>
              <v-icon style="width: 20; height: 20">mdi-magnify</v-icon>
            </v-btn>
          </router-link>
        </div>
        <div class="wrapper-avatar">
          <v-btn icon>
            <v-badge
              v-if="cartQuantity > 0"
              :content="cartQuantity"
              color="error"
            >
              <v-icon>mdi-shopping</v-icon>
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
      </v-container>
    </v-app-bar>
    <v-main>
      <v-container>
        <v-row>
          <v-col cols="12"
            ><h2>Giỏ hàng của bạn ({{ cartQuantity }})</h2></v-col
          >
          <v-col cols="12" md="9">
            <div v-for="(item, i) in Carts" :key="i">
              <v-card>
                <v-card-text>
                  <div style="display: flex">
                    <v-avatar size="x-small" style="border: 1px solid #cfd2d4">
                      <v-img
                        alt="Avatar"
                        :src="item.product.shop.shopImage"
                      ></v-img>
                    </v-avatar>
                    <div style="margin-left: 10px">
                      <b>{{ item.product.shop.shopName }}</b>
                    </div>
                  </div>
                </v-card-text>
                <!-- <v-checkbox color="red" label="Chọn tất cả"> </v-checkbox> -->
                <v-card-text class="wrapper-cart">
                  <div
                    style="
                      display: flex;
                      width: 35%;
                      justify-content: space-between;
                      gap: 10px;
                      flex-grow: 0.5px;
                    "
                  >
                    <v-checkbox color="red" v-model="total" :value="item">
                    </v-checkbox>

                    <v-img
                      width="60px"
                      style="border-radius: 6px; width: 60px"
                      :src="item.product.avartarImage"
                    ></v-img>
                    <a
                      style="
                        /* -webkit-box-orient: vertical; */
                        /* display: -webkit-box; */
                        overflow: hidden;
                        /* -webkit-line-clamp: 1; */
                        text-overflow: ellipsis;
                        white-space: nowrap;
                        min-width: 0;
                      "
                    >
                      {{ item.product.productName }}
                    </a>
                  </div>
                  <div>
                    <b
                      >{{
                        Math.ceil(
                          (item.product.price * (100 - item.product.discount)) /
                            100000
                        )
                      }}.000đ</b
                    >
                    <p v-if="item.product.discount > 0" style="color: gray">
                      <i
                        ><del>{{ item.product.price / 1000 }}.000đ </del></i
                      >
                    </p>
                  </div>
                  <div style="display: flex">
                    <span>
                      <!-- <v-btn variant="outlined" icon="mdi-minus"></v-btn> -->
                      <button
                        :disabled="item.quantity === 1"
                        @click="decreaseQuantity(item)"
                        class="input-quatity button-input"
                      >
                        <v-icon>mdi-minus</v-icon>
                      </button>
                      <input
                        disabled="disabled"
                        v-model="item.quantity"
                        class="input-quatity"
                        inputmode="numeric"
                        min="1"
                        :max="item.product.quantity"
                      />
                      <button
                        :disabled="item.quantity === item.product.quantity"
                        @click="increaseQuantity(item)"
                        class="input-quatity button-input"
                      >
                        <v-icon>mdi-plus</v-icon>
                      </button>
                    </span>
                  </div>
                  <v-icon>mdi-heart-outline</v-icon>
                  <v-icon @click="OnDelete" v-bind="props">mdi-delete</v-icon>
                  <v-dialog v-model="turn" persistent max-width="500">
                    <v-card title="Xác nhận" v-model="turn">
                      <v-card-text> Xóa sản phẩm khỏi giỏ hàng? </v-card-text>

                      <v-card-actions>
                        <v-spacer></v-spacer>

                        <v-btn text="Thoát" @click="close()"></v-btn>

                        <v-sheet>
                          <v-snackbar :timeout="2000">
                            <template v-slot:activator="{ props }">
                              <v-btn
                                text="Xóa"
                                v-bind="props"
                                color="red"
                                @click="Delete(item)"
                              ></v-btn>
                            </template>
                            <v-icon color="success"
                              >mdi-check-circle-outline</v-icon
                            >
                            {{ mess }}
                          </v-snackbar>
                        </v-sheet>
                      </v-card-actions>
                    </v-card>
                  </v-dialog>
                </v-card-text>
              </v-card>
            </div>
          </v-col>
          <v-col cols="12" md="3">
            <v-card>
              <v-card-text>
                <v-icon>mdi-ticket-percent</v-icon>
                <b> Mã ưu đãi Sendo (42)</b>
              </v-card-text>
              <v-divider></v-divider>
              <v-card-text>
                Tạm tính:
                <b style="font-size: 20px; float: right"
                  >{{ cartTotalAmount }}đ</b
                >
              </v-card-text>
              <v-card-actions>
                <v-btn
                  height="40"
                  width="100%"
                  style="color: white; background-color: red"
                  >Mua ngay</v-btn
                >
              </v-card-actions>
            </v-card>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import axios from "axios";
export default {
  name: "CartList",
  data() {
    return {
      Carts: [],
      cartQuantity: 0,
      quantity: 1,
      total: [],
      Cart: {},
      sum: 0,
      search: "",
      mess: "",
      productId: 0,
      turn: false,
    };
  },
  created() {
    this.CartNumber();
    this.ListCart();
  },
  computed: {
    cartTotalAmount() {
      let sum = 0;
      for (let item in this.total) {
        sum =
          sum +
          Math.ceil(
            (this.total[item].product.price *
              (100 - this.total[item].product.discount)) /
              100000
          ) *
            1000 *
            this.total[item].quantity;
      }
      console.log(this.total);
      return sum;
    },
  },
  methods: {
    OnDelete() {
      this.turn = true;
    },
    close() {
      this.turn = false;
    },
    Delete(cart) {
      const index = this.Carts.indexOf(cart);

      if (index !== -1) {
        this.Carts.splice(index, 1);
      }
      this.cartQuantity -= cart.quantity;
      this.DeleteProduct(cart.cartId);
      // this.$router.push({ path: this.$route.path });
      this.turn = false;
    },
    increaseQuantity(cart) {
      cart.quantity++;
      this.cartQuantity++;
      this.Cart.cartId = cart.cartId;
      this.Cart.quantity = cart.quantity;
      this.UpdateQuantity(this.Cart);
    },
    decreaseQuantity(cart) {
      cart.quantity--;
      this.cartQuantity--;
      this.Cart.cartId = cart.cartId;
      this.Cart.quantity = cart.quantity;
      this.UpdateQuantity(this.Cart);
    },
    CartNumber() {
      axios
        .get("https://localhost:7107/api/Product/QuantityCart")
        .then((response) => {
          this.cartQuantity = response.data;
        });
    },
    ListCart() {
      axios
        .get("https://localhost:7107/api/Product/ListCart")
        .then((response) => {
          this.Carts = response.data;
        });
    },
    UpdateQuantity(cart) {
      axios
        .put("https://localhost:7107/api/Product/UpdateCart", cart)
        .then((response) => {
          this.cartQuantity = response.data;
        });
    },
    DeleteProduct(id) {
      axios
        .delete(`https://localhost:7107/api/Product/DeleteProduct?id=${id}`)
        .then((response) => {
          this.mess = response.data;
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
  position: relative;
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
.input-quatity {
  border: 1px solid #cfd2d4;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 700;
  height: 2.2rem;
  margin: 2px;
  outline: 0;
  text-align: center;
  width: 2.2rem;
}
.button-input {
  background-color: #cfd2d4;
}
.wrapper-card {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}
.detail-card {
  margin-left: 30px;
}
.wrapper-card {
  display: flex;
  gap: 20px;
  flex-wrap: wrap;
  justify-content: baseline;
  padding: 60px 0;
}
.card-product {
  flex-basis: 20%;
}
.wrapper-cart {
  display: flex;
  gap: 15px;
  justify-content: space-around;
}
</style>
