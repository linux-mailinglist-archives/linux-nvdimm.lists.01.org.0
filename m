Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C2E346FEB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Mar 2021 04:09:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0FFA0100EB342;
	Tue, 23 Mar 2021 20:09:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.11.71.1; helo=ozlabs.org; envelope-from=dgibson@ozlabs.org; receiver=<UNKNOWN> 
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5A84A100EB339
	for <linux-nvdimm@lists.01.org>; Tue, 23 Mar 2021 20:09:43 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4F4tWT0dtKz9sWF; Wed, 24 Mar 2021 14:09:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1616555381;
	bh=7vs78CUV3Q2Z4OyTs+/YLGlaAhKABcuASbEmR38LrP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7Gbb1uuTttwRbmQG47kOo554z8FLmDf8WD8bRz5ihSnv6V4CFxT/+uhP7MAiQyBD
	 bBvw39uM8nUYpBS48QIXkWmAlLJS18gGTfD7hyN0tADen3zlsTmYlWHoyisstWhcjb
	 kPBn8sBDb+fZ0VJn9ll2/j1rsxbyRv/ll038PHmA=
Date: Wed, 24 Mar 2021 14:07:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] spapr: nvdimm: Implement H_SCM_FLUSH hcall
Message-ID: <YFqs8M1dHAFhdCL6@yekko.fritz.box>
References: <161650723087.2959.8703728357980727008.stgit@6532096d84d3>
 <161650725183.2959.12071056430236337803.stgit@6532096d84d3>
MIME-Version: 1.0
In-Reply-To: <161650725183.2959.12071056430236337803.stgit@6532096d84d3>
Message-ID-Hash: OVXBXS7Y6VOFAV4OR6QWYAIG7GYCEFLB
X-Message-ID-Hash: OVXBXS7Y6VOFAV4OR6QWYAIG7GYCEFLB
X-MailFrom: dgibson@ozlabs.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: sbhat@linux.vnet.ibm.com, groug@kaod.org, qemu-ppc@nongnu.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, qemu-devel@nongnu.org, aneesh.kumar@linux.ibm.com, linux-nvdimm@lists.01.org, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OVXBXS7Y6VOFAV4OR6QWYAIG7GYCEFLB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============0298865144246017250=="


--===============0298865144246017250==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5/M/TtwHXsRocSfA"
Content-Disposition: inline


--5/M/TtwHXsRocSfA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 23, 2021 at 09:47:38AM -0400, Shivaprasad G Bhat wrote:
> The patch adds support for the SCM flush hcall for the nvdimm devices.
> To be available for exploitation by guest through the next patch.
>=20
> The hcall expects the semantics such that the flush to return
> with H_BUSY when the operation is expected to take longer time along
> with a continue_token. The hcall to be called again providing the
> continue_token to get the status. So, all fresh requsts are put into
> a 'pending' list and flush worker is submitted to the thread pool.
> The thread pool completion callbacks move the requests to 'completed'
> list, which are cleaned up after reporting to guest in subsequent
> hcalls to get the status.
>=20
> The semantics makes it necessary to preserve the continue_tokens
> and their return status even across migrations. So, the pre_save
> handler for the device waits for the flush worker to complete and
> collects all the hcall states from 'completed' list. The necessary
> nvdimm flush specific vmstate structures are added to the spapr
> machine vmstate.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

An overal question: surely the same issue must arise on x86 with
file-backed NVDIMMs.  How do they handle this case?

> ---
>  hw/ppc/spapr.c                |    6 +
>  hw/ppc/spapr_nvdimm.c         |  240 +++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h        |   11 ++
>  include/hw/ppc/spapr_nvdimm.h |   12 ++
>  4 files changed, 268 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d56418ca29..fdb0c73a2c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1607,6 +1607,8 @@ static void spapr_machine_reset(MachineState *machi=
ne)
>          spapr->ov5_cas =3D spapr_ovec_clone(spapr->ov5);
>      }
> =20
> +    spapr_nvdimm_finish_flushes();
> +
>      /* DRC reset may cause a device to be unplugged. This will cause tro=
ubles
>       * if this device is used by another device (eg, a running vhost bac=
kend
>       * will crash QEMU if the DIMM holding the vring goes away). To avoi=
d such
> @@ -2003,6 +2005,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_cap_ccf_assist,
>          &vmstate_spapr_cap_fwnmi,
>          &vmstate_spapr_fwnmi,
> +        &vmstate_spapr_nvdimm_flush_states,
>          NULL
>      }
>  };
> @@ -2997,6 +3000,9 @@ static void spapr_machine_init(MachineState *machin=
e)
>      }
> =20
>      qemu_cond_init(&spapr->fwnmi_machine_check_interlock_cond);
> +    qemu_mutex_init(&spapr->spapr_nvdimm_flush_states_lock);

Do you actually need an extra mutex, or can you rely on the BQL?

> +    QLIST_INIT(&spapr->pending_flush_states);
> +    QLIST_INIT(&spapr->completed_flush_states);
>  }
> =20
>  #define DEFAULT_KVM_TYPE "auto"
> diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> index 8cf3fb2ffb..883317c1ed 100644
> --- a/hw/ppc/spapr_nvdimm.c
> +++ b/hw/ppc/spapr_nvdimm.c
> @@ -22,14 +22,17 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "qapi/error.h"
>  #include "hw/ppc/spapr_drc.h"
>  #include "hw/ppc/spapr_nvdimm.h"
>  #include "hw/mem/nvdimm.h"
> +#include "qemu/guest-random.h"
>  #include "qemu/nvdimm-utils.h"
>  #include "hw/ppc/fdt.h"
>  #include "qemu/range.h"
>  #include "hw/ppc/spapr_numa.h"
> +#include "block/thread-pool.h"
> =20
>  /*
>   * The nvdimm size should be aligned to SCM block size.
> @@ -371,6 +374,242 @@ static target_ulong h_scm_bind_mem(PowerPCCPU *cpu,=
 SpaprMachineState *spapr,
>      return H_SUCCESS;
>  }
> =20
> +static const VMStateDescription vmstate_spapr_nvdimm_entry =3D {
> +     .name =3D "spapr_nvdimm_states",
> +     .version_id =3D 1,
> +     .minimum_version_id =3D 1,
> +     .fields =3D (VMStateField[]) {
> +         VMSTATE_UINT64(continue_token, SpaprNVDIMMDeviceFlushState),
> +         VMSTATE_INT64(hcall_ret, SpaprNVDIMMDeviceFlushState),
> +         VMSTATE_END_OF_LIST()
> +     },
> +};
> +
> +static bool spapr_nvdimm_states_needed(void *opaque)
> +{
> +     SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +
> +     return (!QLIST_EMPTY(&spapr->pending_flush_states) ||
> +             !QLIST_EMPTY(&spapr->completed_flush_states));
> +}
> +
> +static int spapr_nvdimm_pre_save(void *opaque)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +
> +    while (!QLIST_EMPTY(&spapr->pending_flush_states)) {
> +        aio_poll(qemu_get_aio_context(), true);

Hmm... how long could waiting for all the pending flushes to complete
take?  This could add substanially to the guest's migration downtime,
couldn't it?

> +    }
> +
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_spapr_nvdimm_flush_states =3D {
> +    .name =3D "spapr_nvdimm_hcall_states",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_nvdimm_states_needed,
> +    .pre_save =3D spapr_nvdimm_pre_save,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_QLIST_V(completed_flush_states, SpaprMachineState, 1,
> +                        vmstate_spapr_nvdimm_entry,
> +                        SpaprNVDIMMDeviceFlushState, node),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +/*
> + * Acquire a unique token and reserve it for the new flush state.
> + */
> +static SpaprNVDIMMDeviceFlushState *spapr_nvdimm_init_new_flush_state(vo=
id)
> +{
> +    Error *err =3D NULL;
> +    uint64_t token;
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    SpaprNVDIMMDeviceFlushState *tmp, *next, *state;
> +
> +    state =3D g_malloc0(sizeof(*state));
> +
> +    qemu_mutex_lock(&spapr->spapr_nvdimm_flush_states_lock);
> +retry:
> +    if (qemu_guest_getrandom(&token, sizeof(token), &err) < 0) {

Using getrandom seems like overkill, why not just use a counter?

> +        error_report_err(err);
> +        g_free(state);
> +        qemu_mutex_unlock(&spapr->spapr_nvdimm_flush_states_lock);
> +        return NULL;
> +    }
> +
> +    if (!token) /* Token should be non-zero */
> +        goto retry;
> +
> +    /* If the token already in use, get a new one */
> +    QLIST_FOREACH_SAFE(tmp, &(spapr->pending_flush_states), node, next) {
> +        if (tmp->continue_token =3D=3D token) {
> +            goto retry;
> +        }
> +    }
> +    QLIST_FOREACH_SAFE(tmp, &(spapr->completed_flush_states), node, next=
) {
> +        if (tmp->continue_token =3D=3D token) {
> +            goto retry;
> +        }
> +    }
> +
> +    state->continue_token =3D token;
> +    QLIST_INSERT_HEAD(&spapr->pending_flush_states, state, node);
> +
> +    qemu_mutex_unlock(&spapr->spapr_nvdimm_flush_states_lock);
> +
> +    return state;
> +}
> +
> +/*
> + * spapr_nvdimm_finish_flushes
> + *      Waits for all pending flush requests to complete
> + *      their execution and free the states
> + */
> +void spapr_nvdimm_finish_flushes(void)
> +{
> +    SpaprNVDIMMDeviceFlushState *state, *next;
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());

The caller has natural access to the machine, so pass it in rather
than using the global.

> +
> +    /*
> +     * No contention here when called on reset path, the main loop thread
> +     * which calls the pending BHs has gotten out running in the reset p=
ath,
> +     * finally reaching here. Other code path being guest
> +     * h_client_architecture_support, thats early boot up.
> +     */
> +
> +    while (!QLIST_EMPTY(&spapr->pending_flush_states)) {
> +        aio_poll(qemu_get_aio_context(), true);
> +    }
> +
> +    QLIST_FOREACH_SAFE(state, &spapr->completed_flush_states, node, next=
) {
> +        QLIST_REMOVE(state, node);
> +        g_free(state);
> +    }
> +}
> +
> +/*
> + * spapr_nvdimm_get_hcall_status
> + *      Fetches the status of the hcall worker and returns H_BUSY
> + *      if the worker is still running.
> + */
> +static int spapr_nvdimm_get_flush_status(uint64_t token)
> +{
> +    int ret =3D H_LONG_BUSY_ORDER_10_MSEC;
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());

The callers have natural access to spapr, so pass it in rather than
using the global.

> +    SpaprNVDIMMDeviceFlushState *state, *node;
> +
> +    qemu_mutex_lock(&spapr->spapr_nvdimm_flush_states_lock);
> +    QLIST_FOREACH_SAFE(state, &spapr->pending_flush_states, node, node) {
> +        if (state->continue_token =3D=3D token) {
> +            goto exit;
> +        }
> +    }
> +    ret =3D H_P2; /* If not found in complete list too, invalid token */
> +    QLIST_FOREACH_SAFE(state, &spapr->completed_flush_states, node, node=
) {
> +        if (state->continue_token =3D=3D token) {
> +            ret =3D state->hcall_ret;
> +            QLIST_REMOVE(state, node);
> +            g_free(state);
> +            break;
> +        }
> +    }
> +exit:
> +    qemu_mutex_unlock(&spapr->spapr_nvdimm_flush_states_lock);
> +
> +    return ret;
> +}
> +
> +static int flush_worker_cb(void *opaque)
> +{
> +    int ret =3D H_SUCCESS;
> +    SpaprNVDIMMDeviceFlushState *state =3D opaque;
> +
> +    /* flush raw backing image */
> +    if (qemu_fdatasync(state->backend_fd) < 0) {
> +        error_report("papr_scm: Could not sync nvdimm to backend file: %=
s",
> +                     strerror(errno));
> +        ret =3D H_HARDWARE;
> +    }
> +
> +    return ret;
> +}
> +
> +static void spapr_nvdimm_flush_completion_cb(void *opaque, int hcall_ret)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    SpaprNVDIMMDeviceFlushState *state =3D opaque;
> +
> +    qemu_mutex_lock(&spapr->spapr_nvdimm_flush_states_lock);
> +
> +    state->hcall_ret =3D hcall_ret;
> +    QLIST_REMOVE(state, node);
> +    QLIST_INSERT_HEAD(&spapr->completed_flush_states, state, node);
> +
> +    qemu_mutex_unlock(&spapr->spapr_nvdimm_flush_states_lock);
> +}
> +
> +/*
> + * H_SCM_FLUSH
> + * Input: drc_index, continue-token
> + * Out: continue-token
> + * Return Value: H_SUCCESS, H_Parameter, H_P2, H_BUSY
> + *
> + * Given a DRC Index Flush the data to backend NVDIMM device.
> + * The hcall returns H_BUSY when the flush takes longer time and the hca=
ll

It returns one of the H_LONG_BUSY values, not actual H_BUSY, doesn't
it?


> + * needs to be issued multiple times in order to be completely serviced.
> + * The continue-token from the output to be passed in the argument list =
of
> + * subsequent hcalls until the hcall is completely serviced at which
> + * point H_SUCCESS or other error is returned.
> + */
> +static target_ulong h_scm_flush(PowerPCCPU *cpu, SpaprMachineState *spap=
r,
> +                                      target_ulong opcode, target_ulong =
*args)
> +{
> +    int ret;
> +    uint32_t drc_index =3D args[0];
> +    uint64_t continue_token =3D args[1];
> +    SpaprDrc *drc =3D spapr_drc_by_index(drc_index);
> +    PCDIMMDevice *dimm;
> +    HostMemoryBackend *backend =3D NULL;
> +    SpaprNVDIMMDeviceFlushState *state;
> +    ThreadPool *pool =3D aio_get_thread_pool(qemu_get_aio_context());
> +
> +    if (!drc || !drc->dev ||
> +        spapr_drc_type(drc) !=3D SPAPR_DR_CONNECTOR_TYPE_PMEM) {
> +        return H_PARAMETER;
> +    }
> +
> +    if (continue_token !=3D 0) {
> +        ret =3D spapr_nvdimm_get_flush_status(continue_token);
> +        if (H_IS_LONG_BUSY(ret)) {
> +            args[0] =3D continue_token;
> +        }
> +
> +        return ret;
> +    }
> +
> +    dimm =3D PC_DIMM(drc->dev);
> +    backend =3D MEMORY_BACKEND(dimm->hostmem);
> +
> +    state =3D spapr_nvdimm_init_new_flush_state();
> +    if (!state) {
> +        return H_P2;

AFAICT the only way init_new_flush_state() fails is a failure in the
RNG, which definitely isn't a parameter problem.

> +    }
> +
> +    state->backend_fd =3D memory_region_get_fd(&backend->mr);

Is this guaranteed to return a usable fd in all configurations?

> +    thread_pool_submit_aio(pool, flush_worker_cb, state,
> +                           spapr_nvdimm_flush_completion_cb, state);
> +
> +    ret =3D spapr_nvdimm_get_flush_status(state->continue_token);
> +    if (H_IS_LONG_BUSY(ret)) {
> +        args[0] =3D state->continue_token;
> +    }
> +
> +    return ret;

I believe you can rearrange this so the get_flush_status / check /
return is shared between the args[0] =3D=3D 0 and args[0] =3D=3D token path=
s.

> +}
> +
>  static target_ulong h_scm_unbind_mem(PowerPCCPU *cpu, SpaprMachineState =
*spapr,
>                                       target_ulong opcode, target_ulong *=
args)
>  {
> @@ -487,6 +726,7 @@ static void spapr_scm_register_types(void)
>      spapr_register_hypercall(H_SCM_BIND_MEM, h_scm_bind_mem);
>      spapr_register_hypercall(H_SCM_UNBIND_MEM, h_scm_unbind_mem);
>      spapr_register_hypercall(H_SCM_UNBIND_ALL, h_scm_unbind_all);
> +    spapr_register_hypercall(H_SCM_FLUSH, h_scm_flush);
>  }
> =20
>  type_init(spapr_scm_register_types)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 47cebaf3ac..7c27fb3e2d 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -12,10 +12,12 @@
>  #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
>  #include "hw/ppc/xics.h"        /* For ICSState */
>  #include "hw/ppc/spapr_tpm_proxy.h"
> +#include "hw/ppc/spapr_nvdimm.h"
> =20
>  struct SpaprVioBus;
>  struct SpaprPhbState;
>  struct SpaprNvram;
> +struct SpaprNVDIMMDeviceFlushState;
> =20
>  typedef struct SpaprEventLogEntry SpaprEventLogEntry;
>  typedef struct SpaprEventSource SpaprEventSource;
> @@ -245,6 +247,12 @@ struct SpaprMachineState {
>      uint32_t numa_assoc_array[MAX_NODES + NVGPU_MAX_NUM][NUMA_ASSOC_SIZE=
];
> =20
>      Error *fwnmi_migration_blocker;
> +
> +    /* nvdimm flush states */
> +    QemuMutex spapr_nvdimm_flush_states_lock;
> +    QLIST_HEAD(, SpaprNVDIMMDeviceFlushState) pending_flush_states;
> +    QLIST_HEAD(, SpaprNVDIMMDeviceFlushState) completed_flush_states;
> +
>  };
> =20
>  #define H_SUCCESS         0
> @@ -538,8 +546,9 @@ struct SpaprMachineState {
>  #define H_SCM_BIND_MEM          0x3EC
>  #define H_SCM_UNBIND_MEM        0x3F0
>  #define H_SCM_UNBIND_ALL        0x3FC
> +#define H_SCM_FLUSH             0x44C
> =20
> -#define MAX_HCALL_OPCODE        H_SCM_UNBIND_ALL
> +#define MAX_HCALL_OPCODE        H_SCM_FLUSH
> =20
>  /* The hcalls above are standardized in PAPR and implemented by pHyp
>   * as well.
> diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvdimm.h
> index abcacda5d7..c88df2c590 100644
> --- a/include/hw/ppc/spapr_nvdimm.h
> +++ b/include/hw/ppc/spapr_nvdimm.h
> @@ -11,6 +11,7 @@
>  #define HW_SPAPR_NVDIMM_H
> =20
>  #include "hw/mem/nvdimm.h"
> +#include "migration/vmstate.h"
> =20
>  struct SpaprDrc;
>  struct SpaprMachineState;
> @@ -22,5 +23,16 @@ void spapr_dt_persistent_memory(struct SpaprMachineSta=
te *spapr, void *fdt);
>  bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nv=
dimm,
>                             uint64_t size, Error **errp);
>  void spapr_add_nvdimm(DeviceState *dev, uint64_t slot);
> +void spapr_nvdimm_finish_flushes(void);
> +
> +typedef struct SpaprNVDIMMDeviceFlushState {
> +    uint64_t continue_token;
> +    int64_t hcall_ret;
> +    int backend_fd;
> +
> +    QLIST_ENTRY(SpaprNVDIMMDeviceFlushState) node;
> +} SpaprNVDIMMDeviceFlushState;
> +
> +extern const VMStateDescription vmstate_spapr_nvdimm_flush_states;
> =20
>  #endif
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5/M/TtwHXsRocSfA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmBarO4ACgkQbDjKyiDZ
s5KC5hAA4KKNxYRS/MeSK8kQCGSWe4s3pcojDCXDQfkT3r4GsVc3plzY/T/bYamT
UGFEySp/M9VhrNZ5jF5aRPUXMmo037GTIN/nz4ABy+3MIkgg+qpQ4fiFvZBYSObO
/OuOvkFX44gLeDkvsrckz9RfiZuaJL2djcbGNjdZZxVMZjcwmEJikZBeoMAfq0jN
FPOcXuQRijn8WaTAKBojR0Oqj7JnMHJyaMrlr76rgcEgqQ+clUeohCDPZh2kjx4l
TA4O7Q423Gmz4jn5ZdTHO7M9/6QZGGmA25cKXj0G2RWC9DDYsx1WLCFAMchWUzRn
vO/Qvr0GqvNl4uHCjaTgZjmXaH1Bz0Iz/WEHPpKkJmQrGtFddLyyyUtIfvlAkipj
Ltf1MR/HeOd94GOSkLnX5r2/YI3oDUZx4q4/SZpi52QcDxaKrpnEfel3sx6FrXbj
mDFiKwa5bCQmzPdjbkBbkaY+i5xS8Q78+ClstBgLNDCNl4cidx5FoXBrgBA6iWia
6AdCyd3gzR4LsTL/doaUMCLAW1buda/AHOfhXFxidinw0uv3WLwTxIXIrpSYIr9x
ZNnnne2fWHGv1O946E97BCTzGRTMg24GRP1KRktis3g3l+TZF+e+Z51MZPwv+53M
gMC0OSutGGx2CQK54xz+oqLYprAMQNk9wtqU1PwIDGZRl06cnXE=
=cF+r
-----END PGP SIGNATURE-----

--5/M/TtwHXsRocSfA--

--===============0298865144246017250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============0298865144246017250==--
