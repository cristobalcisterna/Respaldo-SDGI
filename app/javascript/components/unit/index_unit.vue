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
              label="Añadir unidad"
              type="is-info"
              icon-left="plus"
              @click="createUnit()"
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
                <new-unit
                  modal-cancel="true"
                  :modal-header="'Registro de Unidad'"
                  query-type="create"
                  @close="closeModalCreate"
                ></new-unit>
              </template>
            </b-modal>

          </div>
          <div class="column">
            <b-table
              id="table"
              :data="units"
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
                field="name_unit"
                label="Nombre Unidad"
                sortable
                searchable
              >

                <template v-slot="props">
                <a href="#" type="is-info" @click="Clickshowunit(props.row.id)">{{ props.row.name_unit }}</a>
           
                </template>
              </b-table-column>

              <b-table-column
                field="description_unit"
                label="Descripción"
                sortable
                searchable
              >

                <template v-slot="props">
                  {{ props.row.description_unit }}
                </template>
              </b-table-column>

              <b-table-column
                field="identification_number_unit"
                label="N° Identificación"
                sortable
                searchable
              >

                <template v-slot="props">
                  {{ props.row.identification_number_unit }}
                </template>
              </b-table-column>

              <b-table-column field="id" width="10" v-slot="props">
                <b-tooltip label="Ver detalle" type="is-info">
                <b-icon
              pack="fas"
              icon="eye"
              size="is-medium"
              @click.native="Clickshowunit(props.row.id)"/>
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
import NewUnit from "./new_unit.vue";
import ShowUnit from "./show_unit.vue";
export default {
  data() {
    return {
      units: [],
      canCancel: ["escape"],
      isModalActive: false,
      isModalActiveShow: false,
      selected: null,
    };
  },
  components: {
    VuePaginateAl,
    NewUnit,
    ShowUnit,
  },
  props: ["unitId"],
  methods: {
    async getunit() {
      const response = await axios.get("http://localhost:3000/units.json");
      this.units = response.data;
    },
    async Clicknewunit() {
      const response = (window.location.href = "/units/new");
    },
    async Clickshowunit(item) {
      const response = (window.location.href = "/units/" + item);
    },
    async createUnit() {
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
    this.getunit();
  },
};
</script>


