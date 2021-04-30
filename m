Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20F536FD55
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Apr 2021 17:09:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5660E100EB338;
	Fri, 30 Apr 2021 08:08:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=stefanha@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EAEBD100EBB62
	for <linux-nvdimm@lists.01.org>; Fri, 30 Apr 2021 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619795333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9OmyH1RrzLEXuN3YYBOli7Z1fQZLCvh8PHugvMNpZ5c=;
	b=bykVMyd0P8cnbZtq/M4hx3U2c1UZXiCiZZvuBQA24WeTHoaMLU/fBImcW1IMJmjeSmRXfA
	r1w3mquHXcOw6MkTvN5fvFX6v0osig6XTVP9FHAUaxsgjPF4EjSZWTJOg3UxI5Ji8ls79U
	tC4P4oUGx5vc/UETe3aer9sjx6pRSq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-TiW5yE8ZNgCa70ECbzFgHg-1; Fri, 30 Apr 2021 11:08:50 -0400
X-MC-Unique: TiW5yE8ZNgCa70ECbzFgHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FBB679EC2;
	Fri, 30 Apr 2021 15:08:47 +0000 (UTC)
Received: from localhost (ovpn-112-107.ams2.redhat.com [10.36.112.107])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0DFF35D9DD;
	Fri, 30 Apr 2021 15:08:41 +0000 (UTC)
Date: Fri, 30 Apr 2021 16:08:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 0/3] nvdimm: Enable sync-dax property for nvdimm
Message-ID: <YIwdeKzh/xJGX7AI@stefanha-x1.localdomain>
References: <161966810162.652.13723419108625443430.stgit@17be908f7c1c>
 <YIrW4bwbR1R0CWm/@stefanha-x1.localdomain>
 <433e352d-5341-520c-5c57-79650277a719@linux.ibm.com>
 <YIuHJkwkDiHONYwp@yekko>
MIME-Version: 1.0
In-Reply-To: <YIuHJkwkDiHONYwp@yekko>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: 7B5ILKQHMPN5LTVCSFWG6F4V2DTT3TYW
X-Message-ID-Hash: 7B5ILKQHMPN5LTVCSFWG6F4V2DTT3TYW
X-MailFrom: stefanha@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, groug@kaod.org, qemu-ppc@nongnu.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, peter.maydell@linaro.org, eblake@redhat.com, qemu-arm@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, haozhong.zhang@intel.com, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, armbru@redhat.com, qemu-devel@nongnu.org, linux-nvdimm@lists.01.org, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7B5ILKQHMPN5LTVCSFWG6F4V2DTT3TYW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============4788989788902518607=="


--===============4788989788902518607==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VstCjnrIpVAx4Zbs"
Content-Disposition: inline


--VstCjnrIpVAx4Zbs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 30, 2021 at 02:27:18PM +1000, David Gibson wrote:
> On Thu, Apr 29, 2021 at 10:02:23PM +0530, Aneesh Kumar K.V wrote:
> > On 4/29/21 9:25 PM, Stefan Hajnoczi wrote:
> > > On Wed, Apr 28, 2021 at 11:48:21PM -0400, Shivaprasad G Bhat wrote:
> > > > The nvdimm devices are expected to ensure write persistence during =
power
> > > > failure kind of scenarios.
> > > >=20
> > > > The libpmem has architecture specific instructions like dcbf on POW=
ER
> > > > to flush the cache data to backend nvdimm device during normal writ=
es
> > > > followed by explicit flushes if the backend devices are not synchro=
nous
> > > > DAX capable.
> > > >=20
> > > > Qemu - virtual nvdimm devices are memory mapped. The dcbf in the gu=
est
> > > > and the subsequent flush doesn't traslate to actual flush to the ba=
ckend
> > > > file on the host in case of file backed v-nvdimms. This is addresse=
d by
> > > > virtio-pmem in case of x86_64 by making explicit flushes translatin=
g to
> > > > fsync at qemu.
> > > >=20
> > > > On SPAPR, the issue is addressed by adding a new hcall to
> > > > request for an explicit flush from the guest ndctl driver when the =
backend
> > > > nvdimm cannot ensure write persistence with dcbf alone. So, the app=
roach
> > > > here is to convey when the hcall flush is required in a device tree
> > > > property. The guest makes the hcall when the property is found, ins=
tead
> > > > of relying on dcbf.
> > >=20
> > > Sorry, I'm not very familiar with SPAPR. Why add a hypercall when the
> > > virtio-nvdimm device already exists?
> > >=20
> >=20
> > On virtualized ppc64 platforms, guests use papr_scm.ko kernel drive for
> > persistent memory support. This was done such that we can use one kernel
> > driver to support persistent memory with multiple hypervisors. To avoid
> > supporting multiple drivers in the guest, -device nvdimm Qemu command-l=
ine
> > results in Qemu using PAPR SCM backend. What this patch series does is =
to
> > make sure we expose the correct synchronous fault support, when we back=
 such
> > nvdimm device with a file.
> >=20
> > The existing PAPR SCM backend enables persistent memory support with the
> > help of multiple hypercall.
> >=20
> > #define H_SCM_READ_METADATA     0x3E4
> > #define H_SCM_WRITE_METADATA    0x3E8
> > #define H_SCM_BIND_MEM          0x3EC
> > #define H_SCM_UNBIND_MEM        0x3F0
> > #define H_SCM_UNBIND_ALL        0x3FC
> >=20
> > Most of them are already implemented in Qemu. This patch series impleme=
nts
> > H_SCM_FLUSH hypercall.
>=20
> The overall point here is that we didn't define the hypercall.  It was
> defined in order to support NVDIMM/pmem devices under PowerVM.  For
> uniformity between PowerVM and KVM guests, we want to support the same
> hypercall interface on KVM/qemu as well.

Okay, that's fine. Now Linux and QEMU have multiple ways of doing this,
but it's fair enough if it's an existing platform hypercall.

Stefan

--VstCjnrIpVAx4Zbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCMHXgACgkQnKSrs4Gr
c8hmgwf/XTtU49hZwgyXRnASpP3xkIjBSe84ajsAUZJpdfEhIcZBTOuQE3kZqu5G
1Q5Cl+nAJn8r7OfLQv6efwm4Nn4N1lsXf1pecLk1iemBIl9XxZg5pnYvYwIIn71I
bj2i/Sa8YOzP6NoSpiG8ydV57RC/fwVz8K1wolnS7qS6ysKs10ch/TfUYmsDq3Be
4mIXx9mh1cWxq5pBYeGMoA3ZEp8ja0jdr6LLqETClhDzP4R4pd0Oh6Zi07x4D0eH
JZzlQ8CUuomNX1ScXi6XAYGy3reRLeSLr2Rop6KptY3UN+dTQ+isXrUB4CX6fjbG
YAc8GbInVoW5oIYDPvNnr3wQWPmYZg==
=yVLh
-----END PGP SIGNATURE-----

--VstCjnrIpVAx4Zbs--

--===============4788989788902518607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============4788989788902518607==--
