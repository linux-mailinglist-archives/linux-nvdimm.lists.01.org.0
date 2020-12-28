Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E67F32E3578
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Dec 2020 10:29:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 81CE5100EC1DF;
	Mon, 28 Dec 2020 01:29:43 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.11.71.1; helo=ozlabs.org; envelope-from=dgibson@ozlabs.org; receiver=<UNKNOWN> 
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 10A5A100ED497
	for <linux-nvdimm@lists.01.org>; Mon, 28 Dec 2020 01:29:40 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4D4C1Y2N7jz9sW8; Mon, 28 Dec 2020 20:29:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1609147777;
	bh=8A/a80aMSVI1J6qMz+x23Z7MlE9J/dHR1C8PKR0mx7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ACnzM7EBLzvIRbjra1YNBVRqPCA6uKsh8ZLirYDRaPPkQACyCtEi5cDH12E0M4QJV
	 zEVOGz//eOYTvJvHONwUP2Mt5WkWO0U8GoubhOQZQRY/aHT3yF8WkzQdRBsj+nKTMT
	 rpGsx00eourdncSSSJfLn7GMxqFHhqrywMhCquoQ=
Date: Mon, 28 Dec 2020 19:38:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [RFC Qemu PATCH v2 1/2] spapr: drc: Add support for async hcalls
 at the drc level
Message-ID: <20201228083800.GN6952@yekko.fritz.box>
References: <160674929554.2492771.17651548703390170573.stgit@lep8c.aus.stglabs.ibm.com>
 <160674938210.2492771.1728601884822491679.stgit@lep8c.aus.stglabs.ibm.com>
 <20201221130853.15c8ddfd@bahia.lan>
MIME-Version: 1.0
In-Reply-To: <20201221130853.15c8ddfd@bahia.lan>
Message-ID-Hash: CDY4S5XEP7ZTJOTCZL4PYDU774K3UQFI
X-Message-ID-Hash: CDY4S5XEP7ZTJOTCZL4PYDU774K3UQFI
X-MailFrom: dgibson@ozlabs.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, xiaoguangrong.eric@gmail.com, mst@redhat.com, imammedo@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, linux-nvdimm@lists.01.org, aneesh.kumar@linux.ibm.com, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CDY4S5XEP7ZTJOTCZL4PYDU774K3UQFI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============3208322024802858372=="


--===============3208322024802858372==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nRwNdQxTdQ7rZk9A"
Content-Disposition: inline


--nRwNdQxTdQ7rZk9A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 21, 2020 at 01:08:53PM +0100, Greg Kurz wrote:
> Hi Shiva,
>=20
> On Mon, 30 Nov 2020 09:16:39 -0600
> Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
>=20
> > The patch adds support for async hcalls at the DRC level for the
> > spapr devices. To be used by spapr-scm devices in the patch/es to follo=
w.
> >=20
> > Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> > ---
>=20
> The overall idea looks good but I think you should consider using
> a thread pool to implement it. See below.

I am not convinced, however.  Specifically, attaching this to the DRC
doesn't make sense to me.  We're adding exactly one DRC related async
hcall, and I can't really see much call for another one.  We could
have other async hcalls - indeed we already have one for HPT resizing
- but attaching this to DRCs doesn't help for those.

>=20
> >  hw/ppc/spapr_drc.c         |  149 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  include/hw/ppc/spapr_drc.h |   25 +++++++
> >  2 files changed, 174 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index 77718cde1f..4ecd04f686 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -15,6 +15,7 @@
> >  #include "qapi/qmp/qnull.h"
> >  #include "cpu.h"
> >  #include "qemu/cutils.h"
> > +#include "qemu/guest-random.h"
> >  #include "hw/ppc/spapr_drc.h"
> >  #include "qom/object.h"
> >  #include "migration/vmstate.h"
> > @@ -421,6 +422,148 @@ void spapr_drc_detach(SpaprDrc *drc)
> >      spapr_drc_release(drc);
> >  }
> > =20
> > +
> > +/*
> > + * @drc : device DRC targetting which the async hcalls to be made.
> > + *
> > + * All subsequent requests to run/query the status should use the
> > + * unique token returned here.
> > + */
> > +uint64_t spapr_drc_get_new_async_hcall_token(SpaprDrc *drc)
> > +{
> > +    Error *err =3D NULL;
> > +    uint64_t token;
> > +    SpaprDrcDeviceAsyncHCallState *tmp, *next, *state;
> > +
> > +    state =3D g_malloc0(sizeof(*state));
> > +    state->pending =3D true;
> > +
> > +    qemu_mutex_lock(&drc->async_hcall_states_lock);
> > +retry:
> > +    if (qemu_guest_getrandom(&token, sizeof(token), &err) < 0) {
> > +        error_report_err(err);
> > +        g_free(state);
> > +        qemu_mutex_unlock(&drc->async_hcall_states_lock);
> > +        return 0;
> > +    }
> > +
> > +    if (!token) /* Token should be non-zero */
> > +        goto retry;
> > +
> > +    if (!QLIST_EMPTY(&drc->async_hcall_states)) {
> > +        QLIST_FOREACH_SAFE(tmp, &drc->async_hcall_states, node, next) {
> > +            if (tmp->continue_token =3D=3D token) {
> > +                /* If the token already in use, get a new one */
> > +                goto retry;
> > +            }
> > +        }
> > +    }
> > +
> > +    state->continue_token =3D token;
> > +    QLIST_INSERT_HEAD(&drc->async_hcall_states, state, node);
> > +
> > +    qemu_mutex_unlock(&drc->async_hcall_states_lock);
> > +
> > +    return state->continue_token;
> > +}
> > +
> > +static void *spapr_drc_async_hcall_runner(void *opaque)
> > +{
> > +    int response =3D -1;
> > +    SpaprDrcDeviceAsyncHCallState *state =3D opaque;
> > +
> > +    /*
> > +     * state is freed only after this thread finishes(after pthread_jo=
in()),
> > +     * don't worry about it becoming NULL.
> > +     */
> > +
> > +    response =3D state->func(state->data);
> > +
> > +    state->hcall_ret =3D response;
> > +    state->pending =3D 0;
> > +
> > +    return NULL;
> > +}
> > +
> > +/*
> > + * @drc  : device DRC targetting which the async hcalls to be made.
> > + * token : The continue token to be used for tracking as recived from
> > + *         spapr_drc_get_new_async_hcall_token
> > + * @func() : the worker function which needs to be executed asynchrono=
usly
> > + * @data : data to be passed to the asynchronous function. Worker is s=
upposed
> > + *         to free/cleanup the data that is passed here
>=20
> It'd be cleaner to pass a completion callback and have free/cleanup handl=
ed there.
>=20
> > + */
> > +void spapr_drc_run_async_hcall(SpaprDrc *drc, uint64_t token,
> > +                               SpaprDrcAsyncHcallWorkerFunc *func, voi=
d *data)
> > +{
> > +    SpaprDrcDeviceAsyncHCallState *state;
> > +
> > +    qemu_mutex_lock(&drc->async_hcall_states_lock);
> > +    QLIST_FOREACH(state, &drc->async_hcall_states, node) {
> > +        if (state->continue_token =3D=3D token) {
> > +            state->func =3D func;
> > +            state->data =3D data;
> > +            qemu_thread_create(&state->thread, "sPAPR Async HCALL",
> > +                               spapr_drc_async_hcall_runner, state,
> > +                               QEMU_THREAD_JOINABLE);
>=20
> qemu_thread_create() exits on failure, it shouldn't be called on
> a guest triggerable path, eg. a buggy guest could call it up to
> the point that pthread_create() returns EAGAIN.
>=20
> Please use a thread pool (see thread_pool_submit_aio()). This takes care
> of all the thread housekeeping for you in a safe way, and it provides a
> completion callback API. The implementation could then be just about
> having two lists: one for pending requests (fed here) and one for
> completed requests (fed by the completion callback).
>=20
> > +            break;
> > +        }
> > +    }
> > +    qemu_mutex_unlock(&drc->async_hcall_states_lock);
> > +}
> > +
> > +/*
> > + * spapr_drc_finish_async_hcalls
> > + *      Waits for all pending async requests to complete
> > + *      thier execution and free the states
> > + */
> > +static void spapr_drc_finish_async_hcalls(SpaprDrc *drc)
> > +{
> > +    SpaprDrcDeviceAsyncHCallState *state, *next;
> > +
> > +    if (QLIST_EMPTY(&drc->async_hcall_states)) {
> > +        return;
> > +    }
> > +
> > +    qemu_mutex_lock(&drc->async_hcall_states_lock);
> > +    QLIST_FOREACH_SAFE(state, &drc->async_hcall_states, node, next) {
> > +        qemu_thread_join(&state->thread);
>=20
> With a thread-pool, you'd just need to aio_poll() until the pending list
> is empty and then clear the completed list.
>=20
> > +        QLIST_REMOVE(state, node);
> > +        g_free(state);
> > +    }
> > +    qemu_mutex_unlock(&drc->async_hcall_states_lock);
> > +}
> > +
> > +/*
> > + * spapr_drc_get_async_hcall_status
> > + *      Fetches the status of the hcall worker and returns H_BUSY
> > + *      if the worker is still running.
> > + */
> > +int spapr_drc_get_async_hcall_status(SpaprDrc *drc, uint64_t token)
> > +{
> > +    int ret =3D H_PARAMETER;
> > +    SpaprDrcDeviceAsyncHCallState *state, *node;
> > +
> > +    qemu_mutex_lock(&drc->async_hcall_states_lock);
> > +    QLIST_FOREACH_SAFE(state, &drc->async_hcall_states, node, node) {
> > +        if (state->continue_token =3D=3D token) {
> > +            if (state->pending) {
> > +                ret =3D H_BUSY;
> > +                break;
> > +            } else {
> > +                ret =3D state->hcall_ret;
> > +                qemu_thread_join(&state->thread);
>=20
> Like for qemu_thread_create(), the guest shouldn't be responsible for
> thread housekeeping. Getting the hcall status should just be about
> finding the token in the pending or completed lists.
>=20
> > +                QLIST_REMOVE(state, node);
> > +                g_free(state);
> > +                break;
> > +            }
> > +        }
> > +    }
> > +    qemu_mutex_unlock(&drc->async_hcall_states_lock);
> > +
> > +    return ret;
> > +}
> > +
> >  void spapr_drc_reset(SpaprDrc *drc)
> >  {
> >      SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > @@ -448,6 +591,7 @@ void spapr_drc_reset(SpaprDrc *drc)
> >          drc->ccs_offset =3D -1;
> >          drc->ccs_depth =3D -1;
> >      }
> > +    spapr_drc_finish_async_hcalls(drc);
> >  }
> > =20
> >  static bool spapr_drc_unplug_requested_needed(void *opaque)
> > @@ -558,6 +702,7 @@ SpaprDrc *spapr_dr_connector_new(Object *owner, con=
st char *type,
> >      drc->owner =3D owner;
> >      prop_name =3D g_strdup_printf("dr-connector[%"PRIu32"]",
> >                                  spapr_drc_index(drc));
> > +
>=20
> Unrelated change.
>=20
> >      object_property_add_child(owner, prop_name, OBJECT(drc));
> >      object_unref(OBJECT(drc));
> >      qdev_realize(DEVICE(drc), NULL, NULL);
> > @@ -577,6 +722,10 @@ static void spapr_dr_connector_instance_init(Objec=
t *obj)
> >      object_property_add(obj, "fdt", "struct", prop_get_fdt,
> >                          NULL, NULL, NULL);
> >      drc->state =3D drck->empty_state;
> > +
> > +    qemu_mutex_init(&drc->async_hcall_states_lock);
> > +    QLIST_INIT(&drc->async_hcall_states);
> > +
>=20
> Empty line not needed.
>=20
> >  }
> > =20
> >  static void spapr_dr_connector_class_init(ObjectClass *k, void *data)
> > diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> > index 165b281496..77f6e4386c 100644
> > --- a/include/hw/ppc/spapr_drc.h
> > +++ b/include/hw/ppc/spapr_drc.h
> > @@ -18,6 +18,7 @@
> >  #include "sysemu/runstate.h"
> >  #include "hw/qdev-core.h"
> >  #include "qapi/error.h"
> > +#include "block/thread-pool.h"
> > =20
> >  #define TYPE_SPAPR_DR_CONNECTOR "spapr-dr-connector"
> >  #define SPAPR_DR_CONNECTOR_GET_CLASS(obj) \
> > @@ -168,6 +169,21 @@ typedef enum {
> >      SPAPR_DRC_STATE_PHYSICAL_CONFIGURED =3D 8,
> >  } SpaprDrcState;
> > =20
> > +typedef struct SpaprDrc SpaprDrc;
> > +
> > +typedef int SpaprDrcAsyncHcallWorkerFunc(void *opaque);
> > +typedef struct SpaprDrcDeviceAsyncHCallState {
> > +    uint64_t continue_token;
> > +    bool pending;
> > +
> > +    int hcall_ret;
> > +    SpaprDrcAsyncHcallWorkerFunc *func;
> > +    void *data;
> > +
> > +    QemuThread thread;
> > +
> > +    QLIST_ENTRY(SpaprDrcDeviceAsyncHCallState) node;
> > +} SpaprDrcDeviceAsyncHCallState;
> >  typedef struct SpaprDrc {
> >      /*< private >*/
> >      DeviceState parent;
> > @@ -182,6 +198,10 @@ typedef struct SpaprDrc {
> >      int ccs_offset;
> >      int ccs_depth;
> > =20
> > +    /* async hcall states */
> > +    QemuMutex async_hcall_states_lock;
> > +    QLIST_HEAD(, SpaprDrcDeviceAsyncHCallState) async_hcall_states;
> > +
> >      /* device pointer, via link property */
> >      DeviceState *dev;
> >      bool unplug_requested;
> > @@ -241,6 +261,11 @@ void spapr_drc_detach(SpaprDrc *drc);
> >  /* Returns true if a hot plug/unplug request is pending */
> >  bool spapr_drc_transient(SpaprDrc *drc);
> > =20
> > +uint64_t spapr_drc_get_new_async_hcall_token(SpaprDrc *drc);
> > +void spapr_drc_run_async_hcall(SpaprDrc *drc, uint64_t token,
> > +                               SpaprDrcAsyncHcallWorkerFunc, void *dat=
a);
> > +int spapr_drc_get_async_hcall_status(SpaprDrc *drc, uint64_t token);
> > +
> >  static inline bool spapr_drc_unplug_requested(SpaprDrc *drc)
> >  {
> >      return drc->unplug_requested;
> >=20
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nRwNdQxTdQ7rZk9A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl/pmWcACgkQbDjKyiDZ
s5Iohg//USPWwzRXy6Htm1lgHOQkkmLnhCUkh2zL/mCm4+N3YI8qPPuR+X/LVg1Y
VevigW5RoUsgrw0QJyAhvjiBJJHwT1ZRzui+t5X0dxVGyMz2MAZmEIUCe9+v38R5
eCd3H0gyWQh3MT2bxjFlUDM6PWGIUhirxilOfzK2GJrSYcX6/XYbSZ70n1ooEb8P
rZLOe0BLG4woWRD5U7/s81fiG/mH8pCeUrG55kG2tLI50cIOHM0kH9CimIG4Sd+E
oXZUVdDvA/gNS51QxQnevqkFglvx9e2JuCxzo02X/fdMJOmGakxdH2Z5fnsDUELp
HAPLpTexg6LcKBy2wyfTZylWeXj58r/2GfXd2FTTAOnUhOOWbCCQNltemRxl/91q
MiMLi/wIlP+xboanOP5ryBwPtOUqFjUtF2GP1dSbtJ+YJI6EuFeOEuxCQTMBkQHR
WUYDvGIaWxotfTl7+5qK7NNS8XdykdH6zZGBUgTBcb6XnQCQ7M0CTwuAKq936MaP
3g/ldjIfBvwopbzDWRGXfI1qiGsnylZQLfna/DFIAD3mbX+bVjGi+oteVozJUzun
h7i0IxTf9EyRHAc8BXBS+8isB6HQIYxOKqPqnZC7WNKUtwMdGWn/chYbNLiCwhm5
wuNRcRgn5iKixi4V9r7ug0NcZS1WtX0nVJXbsVLEXH7qMQLxaCw=
=i1pT
-----END PGP SIGNATURE-----

--nRwNdQxTdQ7rZk9A--

--===============3208322024802858372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============3208322024802858372==--
