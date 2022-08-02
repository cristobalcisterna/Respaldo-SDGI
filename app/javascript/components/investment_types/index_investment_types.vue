 <template>
  <section class="b-tooltips">
    <div
      class="box"
      style="margin-top: 60px; margin-left: 300px; margin-right: 300px"
    >
      <h1>Unidades de la facultad</h1>
      <b-tabs>
        <b-tab-item>
          <div class="has-text-right">
            <b-button
              label="Añadir Tipo de inversión"
              type="is-info"
              icon-left="plus"
              @click="createinvestment()"
            ></b-button>
          </div>
          <div> 
            <b-modal
              :active="isModalActive"
              aria-modal
              has-modal-card
              :destroy-on-hide="true"
              aria-role="dialog"
              width="100%"
              :can-cancel="canCancel"
            >
              <template>
                <new-investment-types
                  modal-cancel="true"
                  :modal-header="'Registro de Tipo de inversión'"
                  query-type="create"
                  @close="closeModalCreate"
                ></new-investment-types>
              </template>
            </b-modal>

          </div>
          <div class="column">
            <b-table
              id="table"
              :data="investment_types"
              :paginated="true"
              per-page="8"
              striped
              hoverable
              :pagination-simple="false"
              pagination-active-color="hsl(0, 0%, 0%)"
              pagination-position="bottom"
              default-sort-direction="asc"
              sort-icon="arrow-up"
              aria-next-label="Siguiente"
              aria-previous-label="Anterior"
              aria-page-label="Página"
              aria-current-label="Página actual"
            >
              <b-table-column
                :visible="false"
                field="id"
                label="ID"
                sortable
                searchable
              >

                <template v-slot="props">
                  {{ props.row.id }}
                </template>
              </b-table-column>

              

              <b-table-column
                field="name_investment_type"
                label="Nombre Inversión"
                sortable
                searchable
              >

                <template v-slot="props">
                <a href="#" type="is-info" @click="Clickshowinvestment(props.row.id)">{{ props.row.name_investment_type }}</a>
           
                </template>
              </b-table-column>

              <b-table-column field="id" width="10" v-slot="props">
                <b-tooltip label="Ver detalle" type="is-info">
                <b-icon
              pack="fas"
              icon="eye"
              size="is-medium"
              @click.native="Clickshowinvestment(props.row.id)"/>
              </b-tooltip>
              </b-table-column>
            </b-table>
          </div>
        </b-tab-item>
      </b-tabs>
    </div>
  </section>
</template>


<script>
import axios from "axios";
import VuePaginateAl from "vue-paginate-al";
import NewInvestmentTypes from "./new_investment_types.vue";
import ShowInvestmentTypes from "./show_investment_types.vue";
export default {
  data() {
    return {
      investment_types: [],
      canCancel: ["escape"],
      isModalActive: false,
      isModalActiveShow: false,
      selected: null,
    };
  },
  components: {
    VuePaginateAl,
    NewInvestmentTypes,
    ShowInvestmentTypes,
  },
  props: ["investment_typeId"],
  methods: {
    async getinvestment() {
      const response = await axios.get("http://localhost:3000/investment_types.json");
      this.investment_types = response.data;
    },
    async Clicknewinvestment() {
      const response = (window.location.href = "/investment_types/new");
    },
    async Clickshowinvestment(item) {
      const response = (window.location.href = "/investment_types/" + item);
      console.log(this.item);
    },
    async createinvestment() {
      this.isModalActive = true;
    },
    async closeModalCreate() {
      this.isModalActive = false;
    },
    async ShowModaleUnit(item) {
      this.selected = item;
      this.isModalActiveShow = true;
    },
    async closeModalShow() {
      this.isModalActiveShow = false;
    },
  },
  created() {
    this.getinvestment();
  },
};
</script>


