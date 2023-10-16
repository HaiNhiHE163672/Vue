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
                value="item.productTypeId"
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
      </v-container>
    </v-app-bar>
    <v-main>
      <v-container>
        <v-row>
          <v-col cols="12">
            <v-card width="100%">
              <v-container>
                <v-row dense>
                  <v-col cols="12">
                    <div class="wrapper-card">
                      <!-- class="d-flex flex-wrap justify-space-between" -->
                      <v-img
                        class="detail-card"
                        style="border-radius: 20px; width: 30%; height: 100%"
                        :src="product.avartarImage"
                      >
                      </v-img>

                      <div class="detail-card">
                        <v-card-title>{{ product.productName }}</v-card-title>
                        <v-card-subtitle
                          >Thương hiệu:{{ product.brand }}</v-card-subtitle
                        >
                        <v-card-title style="color: red"
                          >{{
                            Math.ceil(
                              (product.price * (100 - product.discount)) /
                                100000
                            )
                          }}.000đ</v-card-title
                        >
                        <v-card-subtitle>
                          <del> {{ product.price }}đ</del>
                          <span style="color: red; margin: 5px"
                            >Giảm {{ product.discount }}%</span
                          >
                        </v-card-subtitle>
                        <v-card-actions>
                          <v-rating
                            size="x-small"
                            color="orange-lighten-1"
                            active-color="yellow"
                            readonly
                          ></v-rating>
                          <div style="margin: 10px; color: gray">
                            <v-icon>mdi-shopping</v-icon>
                            <span> 0 lượt mua</span>
                          </div>
                        </v-card-actions>

                        <v-card-text>
                          <p>
                            Chọn số lượng:
                            <span style="margin: 70px">
                              <!-- <v-btn variant="outlined" icon="mdi-minus"></v-btn> -->
                              <button
                                :disabled="quantity === 1"
                                @click="decreaseQuantity"
                                class="input-quatity button-input"
                              >
                                <v-icon>mdi-minus</v-icon>
                              </button>
                              <input
                                disabled="disabled"
                                v-model="quantity"
                                class="input-quatity"
                                inputmode="numeric"
                                min="1"
                                :max="product.quantity"
                              />
                              <button
                                :disabled="quantity === product.quantity"
                                @click="increaseQuantity"
                                class="input-quatity button-input"
                              >
                                <v-icon>mdi-plus</v-icon>
                              </button>
                            </span>
                          </p>
                        </v-card-text>
                        <v-card-actions>
                          <v-sheet>
                            <v-snackbar :timeout="2000">
                              <template v-slot:activator="{ props }">
                                <v-btn
                                  height="60"
                                  width="300"
                                  style="
                                    color: #3f4b53;
                                    background-color: #cfd2d4;
                                  "
                                  @click="addCart"
                                  v-bind="props"
                                  >Thêm vào giỏ hàng</v-btn
                                >
                              </template>
                              <v-icon color="success"
                                >mdi-check-circle-outline</v-icon
                              >
                              {{ mess }}
                            </v-snackbar>
                          </v-sheet>

                          <v-spacer></v-spacer>
                          <v-btn
                            height="60"
                            width="300"
                            style="
                              color: white;
                              background-color: red;
                              margin-left: 5px;
                            "
                            >Mua ngay</v-btn
                          >
                        </v-card-actions>
                        <v-divider></v-divider>
                        <v-card-text>
                          <span><b> Ưu đãi dành cho bạn</b> </span>
                          <v-icon style="float: right"
                            >mdi-information-outline</v-icon
                          >
                        </v-card-text>
                        <v-card-text>
                          <v-avatar size="x-small">
                            <v-img
                              src="https://media3.scdn.vn/img4/2022/12_19/k4fhvv3i925lb0CUgGn4.png"
                            ></v-img>
                          </v-avatar>
                          Trả góp Kredivo
                        </v-card-text>
                        <v-divider></v-divider>
                        <v-card-text>
                          <span><b> Quyền lợi khách hàng & Bảo hành</b> </span>
                          <v-icon style="float: right"
                            >mdi-information-outline</v-icon
                          >
                        </v-card-text>
                        <v-card-text>
                          <v-icon color="green-darken-3">mdi-security</v-icon>
                          7 ngày hoàn trả

                          <v-icon
                            style="margin-left: 10px"
                            color="green-darken-3"
                            >mdi-security</v-icon
                          >
                          Bảo hành theo chính sách từ Nhà bán hàng
                        </v-card-text>
                      </div>
                    </div>
                  </v-col>
                </v-row>
              </v-container>
            </v-card>
          </v-col>
          <v-col cols="12" md="5">
            <v-card>
              <v-card-title>Thông tin nhà cung cấp</v-card-title>
              <v-card-text>
                <div style="display: flex">
                  <v-avatar size="x-large" style="border: 1px solid #cfd2d4">
                    <v-img alt="Avatar" :src="shop.shopImage"></v-img>
                  </v-avatar>
                  <div>
                    <b>{{ shop.shopName }}</b>
                    <v-card-subtitle>{{ shop.shopAddress }}</v-card-subtitle>
                  </div>
                </div>
              </v-card-text>
              <v-card-text>
                <div
                  style="
                    display: flex;
                    justify-content: space-between;
                    text-align: center;
                  "
                >
                  <div>
                    <h3>4 năm</h3>
                    <p style="font-size: 12px">Bán ở Sendo</p>
                  </div>
                  <div>
                    <h3>10</h3>
                    <p style="font-size: 12px">Sản phẩm</p>
                  </div>
                  <div>
                    <h3>3 ngày</h3>
                    <p style="font-size: 12px">Chuẩn bị hàng</p>
                  </div>
                  <div>
                    <h3>--</h3>
                    <p style="font-size: 12px">Tỉ lệ phản hồi</p>
                  </div>
                  <div>
                    <h3>--</h3>
                    <p style="font-size: 12px">Shop phản hồi</p>
                  </div>
                </div>
              </v-card-text>
              <v-card-actions
                style="display: flex; justify-content: space-between"
              >
                <v-btn
                  style="
                    width: 40%;
                    color: #3f4b53;
                    background-color: #cfd2d4;
                    flex-wrap: wrap;
                  "
                  >Theo dõi shop</v-btn
                >
                <v-btn
                  style="
                    width: 40%;
                    color: #3f4b53;
                    background-color: #cfd2d4;
                    flex-wrap: wrap;
                  "
                  >Vào shop</v-btn
                >
                <v-btn
                  style="
                    color: #3f4b53;
                    background-color: #cfd2d4;
                    flex-wrap: wrap;
                  "
                >
                  <v-icon>mdi-phone-in-talk</v-icon>
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-col>
          <v-col cols="12" md="7">
            <v-card>
              <v-card-title>Mô tả sản phẩm</v-card-title>
              <v-card-text
                >Giới thiệu sản phẩm Đặc điểm nổi bật:- Dễ dàng sử dụng với hệ
                thống điều khiển cơ, tiện lợi với chương trình nấu đã được cài
                đặt sẵn. - Tiện lợi với khe dựng đứng nắp trên quai nồi - An
                toàn tuyệt đối cho sức khỏe với lòng nồi được làm từ nhôm
                nguyê..</v-card-text
              >
            </v-card>
            <div style="padding-top: 24px; text-align: center">
              <v-card>
                <v-img
                  style="width: 100px; margin: auto"
                  src="https://web-static.scdn.vn/sendo-communication-rating/45bba71-web/media/rating-empty.f56ae9e22805ed6a864d1a540bea0947.svg"
                ></v-img>
                <v-card-title>Chưa có sản phẩm đánh giá.</v-card-title>
                <v-card-subtitle
                  >Chọn mua sản phẩm để là người đầu tiên đánh giá sản phẩm
                  này.</v-card-subtitle
                >
              </v-card>
            </div>
            <div style="padding-top: 24px">
              <v-card>
                <v-col cols="12">
                  <v-card-title>Hỏi về sản phẩm</v-card-title>
                  <v-card-subtitle
                    >Bạn có thắc mắc cần giải đáp?</v-card-subtitle
                  >
                  <v-card-actions>
                    <v-btn
                      block
                      style="color: #3f4b53; background-color: #cfd2d4"
                      >Hỏi shop ngay</v-btn
                    >
                  </v-card-actions>
                </v-col>
              </v-card>
            </div>
          </v-col>
          <v-col cols="12">
            <h4>Ở đây có sản phẩm bạn thích</h4>
            <div>
              <div class="wrapper-card">
                <div
                  v-for="(item, index) in displayRelated"
                  :key="index"
                  value="item"
                  class="card-product"
                >
                  <div class="related">
                    <v-card width="200" style="height: 100%">
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
                            Math.ceil(
                              (item.price * (100 - item.discount)) / 100000
                            )
                          }}.000đ
                        </h3>
                      </v-card-text>
                      <v-card-actions>
                        <router-link
                          :to="{
                            path: `/detail/${item.productId}`,
                            state: { product },
                          }"
                        >
                          <v-btn>Mua Ngay</v-btn></router-link
                        >
                        <!-- <v-card-subtitle>{{
                        item.shop.shopAddress
                      }}</v-card-subtitle> -->
                      </v-card-actions>
                    </v-card>
                  </div>
                </div>
              </div>
            </div>
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      productTypes: [],
      product: {},
      quantity: 1,
      shop: {},
      productRelateds: [],
      productId: 0,
      cartQuantity: 0,
      mess: "",
      search: "",
    };
  },
  created() {
    this.getProduct(this.$route.params.id);
    this.getProductTypes();
    this.CartNumber();
  },
  computed: {
    displayRelated() {
      return this.productRelateds.filter(
        (x) => x.productId !== this.product.productId
      );
    },
  },
  methods: {
    decreaseQuantity() {
      this.quantity--;
    },
    increaseQuantity() {
      this.quantity++;

    },
    getProduct(id) {
      axios.get(`https://localhost:7107/api/Product/${id}`).then((response) => {
        this.product = response.data;
        this.shop = response.data.shop;
      });
    },
    getProductTypes() {
      axios
        .get("https://localhost:7107/api/Product/ListProductType")
        .then((response) => {
          this.productTypes = response.data;
          const index = this.productTypes.findIndex(
            (x) => x.productTypeId === this.product.productTypeId
          );
          this.productRelateds = response.data[index].products;
        });
    },
    addToCart(cart) {
      axios
        .post("https://localhost:7107/api/Product/AddtoCart", cart)
        .then((response) => {
          this.mess = response.data;
        });
    },
    CartNumber() {
      axios
        .get("https://localhost:7107/api/Product/QuantityCart")
        .then((response) => {
          this.cartQuantity = response.data;
        });
    },
    addCart() {
      this.addToCart({
        quantity: this.$data.quantity,
        productId: this.$data.product.productId,
      });
      this.cartQuantity += this.quantity;
    },
    change(id) {
      this.getProduct(id);
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
  margin: 0 0.4rem;
  outline: 0;
  text-align: center;
  width: 3.2rem;
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
  justify-content: stretch;
  padding: 60px 0;
}
.card-product {
  flex-basis: 20%;
}
.related {
  height: 100%;
}
</style>
