Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAAD34F541
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Mar 2021 02:04:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DEEEB100EC1C8;
	Tue, 30 Mar 2021 17:04:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2401:3900:2:1::2; helo=ozlabs.org; envelope-from=dgibson@ozlabs.org; receiver=<UNKNOWN> 
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E6D3E100ED4A4
	for <linux-nvdimm@lists.01.org>; Tue, 30 Mar 2021 17:04:15 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4F96494tplz9sj5; Wed, 31 Mar 2021 11:04:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1617149049;
	bh=0VuGIErLDgaTj9eGNAEDBaL0IO5gHk1nF52hRHiKJYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IePWJXnnQ0BrLw5DbF1SdxQJUwWB4waD7tfc0Rw6m0Ck/rmDFak/XXVvxQMruKiXE
	 PqR7wKOSVwuN+FlC+lAL5r/aYu4imPMS+LXExfdPovbItlS8nolgrMusVaSaSSXsCT
	 0YVi2NVr5P/fP/AGVUnRpUZv7pcvuYqhA/yX5fNE=
Date: Wed, 31 Mar 2021 10:57:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] spapr: nvdimm: Implement H_SCM_FLUSH hcall
Message-ID: <YGO7AYsJNjBFk9pH@yekko.fritz.box>
References: <161650723087.2959.8703728357980727008.stgit@6532096d84d3>
 <161650725183.2959.12071056430236337803.stgit@6532096d84d3>
 <YFqs8M1dHAFhdCL6@yekko.fritz.box>
 <13744465-ca7a-0aaf-5abb-43a70a39c167@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <13744465-ca7a-0aaf-5abb-43a70a39c167@linux.ibm.com>
Message-ID-Hash: TYYNUQOQCVMVKGLI5GY6OMR6NNOSPNYK
X-Message-ID-Hash: TYYNUQOQCVMVKGLI5GY6OMR6NNOSPNYK
X-MailFrom: dgibson@ozlabs.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: sbhat@linux.vnet.ibm.com, groug@kaod.org, qemu-ppc@nongnu.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, qemu-devel@nongnu.org, aneesh.kumar@linux.ibm.com, linux-nvdimm@lists.01.org, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TYYNUQOQCVMVKGLI5GY6OMR6NNOSPNYK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============5121243147575777027=="


--===============5121243147575777027==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3vHyPS3rSEB5kfKk"
Content-Disposition: inline


--3vHyPS3rSEB5kfKk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2021 at 02:53:47PM +0530, Shivaprasad G Bhat wrote:
>=20
> On 3/24/21 8:37 AM, David Gibson wrote:
> > On Tue, Mar 23, 2021 at 09:47:38AM -0400, Shivaprasad G Bhat wrote:
> > > machine vmstate.
> > >=20
> > > Signed-off-by: Shivaprasad G Bhat<sbhat@linux.ibm.com>
> > An overal question: surely the same issue must arise on x86 with
> > file-backed NVDIMMs.  How do they handle this case?
>=20
> Discussed in other threads..
>=20
> ....
>=20
> > >   };
> > > @@ -2997,6 +3000,9 @@ static void spapr_machine_init(MachineState *ma=
chine)
> > >       }
> > >       qemu_cond_init(&spapr->fwnmi_machine_check_interlock_cond);
> > > +    qemu_mutex_init(&spapr->spapr_nvdimm_flush_states_lock);
> > Do you actually need an extra mutex, or can you rely on the BQL?
>=20
> I verified BQL is held at all places where it matters in the context of t=
his
> patch.
>=20
> Safe to get rid of this extra mutex.
>=20
> ...
>=20
> >=20
> > > +{
> > > +     SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > > +
> > > +     return (!QLIST_EMPTY(&spapr->pending_flush_states) ||
> > > +             !QLIST_EMPTY(&spapr->completed_flush_states));
> > > +}
> > > +
> > > +static int spapr_nvdimm_pre_save(void *opaque)
> > > +{
> > > +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > > +
> > > +    while (!QLIST_EMPTY(&spapr->pending_flush_states)) {
> > > +        aio_poll(qemu_get_aio_context(), true);
> > Hmm... how long could waiting for all the pending flushes to complete
> > take?  This could add substanially to the guest's migration downtime,
> > couldn't it?
>=20
>=20
> The time taken depends on the number of dirtied pages and the disk io wri=
te
> speed. The number of dirty pages on host is configureable with tunables

Well, sure, I'm just trying to get an order of magnitude here.

> vm.dirty_background_ratio (10% default on Fedora 32, Ubuntu 20.04),
> vm.dirty_ratio(20%) of host memory and|or vm.dirty_expire_centisecs(30
> seconds). So, the host itself would be flushing the mmaped file on its own
> from time to time. For guests using the nvdimms with filesystem, the flus=
hes
> would have come frequently and the number of dirty pages might be
> less. The

I'm not sure that necessarily follows.

> pmem applications can use the nvdimms without a filesystem. And for such
> guests, the chances that a flush request can come from pmem applications =
at
> the time of migration is less or is random. But, the host would have flus=
hed
> the pagecache on its own when vm.dirty_background_ratio is crossed or
> vm.dirty_expire_centisecs expired. So, the worst case would stands at disk
> io latency for writing the dirtied pages in the last
> vm.dirty_expire_centisecs on host OR latency for writing maximum
> vm.dirty_background_ratio(10%) of host RAM. If you want me to calibrate a=
ny
> particular size, scenario and get the numbers please let me know.

Hmm.  I feel like this could still easily be 10s, maybe 100s of
milliseconds, yes?  Given that typical migration downtime caps are
also in the 100s of milliseconds, this still seems troublesome.  Since
this is part of the device migration itself, this flushing will all
happen during the downtime, but won't be factored into the downtime
estimations.

> ...
> > > +
> > > +/*
> > > + * Acquire a unique token and reserve it for the new flush state.
> > > + */
> > > +static SpaprNVDIMMDeviceFlushState *spapr_nvdimm_init_new_flush_stat=
e(void)
> > > +{
> > > +    Error *err =3D NULL;
> > > +    uint64_t token;
> > > +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > > +    SpaprNVDIMMDeviceFlushState *tmp, *next, *state;
> > > +
> > > +    state =3D g_malloc0(sizeof(*state));
> > > +
> > > +    qemu_mutex_lock(&spapr->spapr_nvdimm_flush_states_lock);
> > > +retry:
> > > +    if (qemu_guest_getrandom(&token, sizeof(token), &err) < 0) {
> > Using getrandom seems like overkill, why not just use a counter?
>=20
> I didnt want a spurious guest to abuse by consuming the return value
> providing
>=20
> a valid "guess-able" counter and the real driver failing
> subsequently.

Why would a guessable value be bad?  The counter would be per-guest,
so AFAICT all a malicious guest could do is mess itself up.

> Also,
> across
>=20
> guest migrations carrying the global counter to destination is another th=
ing
> to ponder.

I don't think you need to: if there are pending flushes on migration
you can set the dest counter to the max id of those, if not you can
reset it to 1 without harm.

Actually.. come to think of it, can't you just use the current max id
of pending flushes + 1 as a new id.


> Let me know if you want me to reconsider using counter.
>=20
> ...
>=20
> > > mm_flush_states_lock);
> > > +
> > > +    return state;
> > > +}
> > > +
> > > +/*
> > > + * spapr_nvdimm_finish_flushes
> > > + *      Waits for all pending flush requests to complete
> > > + *      their execution and free the states
> > > + */
> > > +void spapr_nvdimm_finish_flushes(void)
> > > +{
> > > +    SpaprNVDIMMDeviceFlushState *state, *next;
> > > +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > The caller has natural access to the machine, so pass it in rather
> > than using the global.
>=20
> okay
>=20
> ...
>=20
> > > +
> > > +/*
> > > + * spapr_nvdimm_get_hcall_status
> > > + *      Fetches the status of the hcall worker and returns H_BUSY
> > > + *      if the worker is still running.
> > > + */
> > > +static int spapr_nvdimm_get_flush_status(uint64_t token)
> > > +{
> > > +    int ret =3D H_LONG_BUSY_ORDER_10_MSEC;
> > > +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > The callers have natural access to spapr, so pass it in rather than
> > using the global.
>=20
> Okay
>=20
> ...
>=20
> > > +
> > > +/*
> > > + * H_SCM_FLUSH
> > > + * Input: drc_index, continue-token
> > > + * Out: continue-token
> > > + * Return Value: H_SUCCESS, H_Parameter, H_P2, H_BUSY
> > > + *
> > > + * Given a DRC Index Flush the data to backend NVDIMM device.
> > > + * The hcall returns H_BUSY when the flush takes longer time and the=
 hcall
> > It returns one of the H_LONG_BUSY values, not actual H_BUSY, doesn't
> > it?
>=20
> Yes. I thought its okay to call it just H_BUSY in a generic way. Will fix
> it.
>=20
>=20
> > > + * needs to be issued multiple times in order to be completely servi=
ced.
> > > +        }
> > > +
> > > +        return ret;
> > > +    }
> > > +
> > > +    dimm =3D PC_DIMM(drc->dev);
> > > +    backend =3D MEMORY_BACKEND(dimm->hostmem);
> > > +
> > > +    state =3D spapr_nvdimm_init_new_flush_state();
> > > +    if (!state) {
> > > +        return H_P2;
> > AFAICT the only way init_new_flush_state() fails is a failure in the
> > RNG, which definitely isn't a parameter problem.
>=20
> Will change it to H_HARDWARE.
>=20
>=20
> > > +    }
> > > +
> > > +    state->backend_fd =3D memory_region_get_fd(&backend->mr);
> > Is this guaranteed to return a usable fd in all configurations?
>=20
> Right, for memory-backend-ram this wont work. I think we should
>=20
> not set the hcall-flush-required too for memory-backend-ram. Will fix thi=
s.

Right, but it's good to be defensive here.  I think a bad guest could
initiate this path even if it's not supposed to yes?

> > > +    thread_pool_submit_aio(pool, flush_worker_cb, state,
> > > +                           spapr_nvdimm_flush_completion_cb, state);
> > > +
> > > +    ret =3D spapr_nvdimm_get_flush_status(state->continue_token);
> > > +    if (H_IS_LONG_BUSY(ret)) {
> > > +        args[0] =3D state->continue_token;
> > > +    }
> > > +
> > > +    return ret;
> > I believe you can rearrange this so the get_flush_status / check /
> > return is shared between the args[0] =3D=3D 0 and args[0] =3D=3D token =
paths.
> okay.
>=20
> Thanks,
>=20
> Shiva
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3vHyPS3rSEB5kfKk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmBjuwEACgkQbDjKyiDZ
s5Ircg/+OgiVO+xK9dfDab4erKs6cQDGXpBBL4C1MnX8YuW1rEownNTgtOwXquy2
bK6e0juqlBwryMoJdmiXrzhLrqAU2lw76IJ9MQdFR+aZIlh59jADW9sSuMX8oXJa
rA7URf8xusR75AvrRV2cgGsPSvPpGquipBYPjWFx/54SfTmDPGVa/c22UK41zp9/
LH5WWvXuAiZ5JbIOr+sltjeyoKy358qEq582VSS4n7Pm7QmOpXlunrpLgjflUElv
Dnn7qryInjXDnsvJHZXaO8uCK+Gfsxn+ugeoJsMAgAW4ucnPSNLNgA+8JguPVnO+
n6WFi31gxedrnXb4U2eeibxjC5XXvc/HYZSENNaJKAqMTnhxyoLr7tz3OIs8BSs8
dLb2CaxlsIKQRtFUNPZQLEwW99EEaoF2bmiFevQ8Xow/ZMmdyrWod4YNehri0NC9
Ywm98IwVSw46hCG4yfEi7DKeitRXrgUVzJoeEqyyqLfPtAMzYcSplBNtb+kwjNrk
8umao21LeyY8IbejPkOH7NHC5tMTkk3t9oqpOW3Ot1uMsBH4QxNjfW3JVMB6tfOw
wkTrOXzahterOIlFeCzrcU7DCfaFK1sC46PayuCZv5zbOxNsPwk6B/0JfT3ZDbqF
p57ZkcNbrxWg1nXGtn6CESquKxiinq3BXtzsCwqXNhHK/ESAU7M=
=pLha
-----END PGP SIGNATURE-----

--3vHyPS3rSEB5kfKk--

--===============5121243147575777027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============5121243147575777027==--
