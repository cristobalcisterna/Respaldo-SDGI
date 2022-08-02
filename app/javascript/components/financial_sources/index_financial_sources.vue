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
              label="Añadir Fuente financiera"
              type="is-info"
              icon-left="plus"
              @click="createFinancial()"
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
                <new-financial-sources
                  modal-cancel="true"
                  :modal-header="'Registro de Fuente financiera'"
                  query-type="create"
                  @close="closeModalCreate"
                ></new-financial-sources>
              </template>
            </b-modal>

          </div>
          <div class="column">
            <b-table
              id="table"
              :data="financial_sources"
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
                field="name_financial_source"
                label="Nombre Fuente"
                sortable
                searchable
              >

                <template v-slot="props">
                <a href="#" type="is-info" @click="Clickshowfinancial(props.row.id)">{{ props.row.name_financial_source }}</a>
           
                </template>
              </b-table-column>

              <b-table-column field="id" width="10" v-slot="props">
                <b-tooltip label="Ver detalle" type="is-info">
                <b-icon
              pack="fas"
              icon="eye"
              size="is-medium"
              @click.native="Clickshowfinancial(props.row.id)"/>
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
import NewFinancialSources from "./new_financial_sources.vue";
import ShowFinancialSources from "./show_financial_sources.vue";
export default {
  data() {
    return {
      financial_sources: [],
      canCancel: ["escape"],
      isModalActive: false,
      isModalActiveShow: false,
      selected: null,
    };
  },
  components: {
    VuePaginateAl,
    NewFinancialSources,
    ShowFinancialSources,
  },
  props: ["financial_sourceId"],
  methods: {
    async getfinancial() {
      const response = await axios.get("http://localhost:3000/financial_sources.json");
      this.financial_sources = response.data;
    },
    async Clicknewfinancial() {
      const response = (window.location.href = "/financial_sources/new");
    },
    async Clickshowfinancial(item) {
      const response = (window.location.href = "/financial_sources/" + item);
      console.log(this.item);
    },
    async createFinancial() {
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
    this.getfinancial();
  },
};
</script>


