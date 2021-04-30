Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5111D36F666
	for <lists+linux-nvdimm@lfdr.de>; Fri, 30 Apr 2021 09:29:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B6935100EB325;
	Fri, 30 Apr 2021 00:28:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.11.71.1; helo=ozlabs.org; envelope-from=dgibson@ozlabs.org; receiver=<UNKNOWN> 
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1CFC0100EB859
	for <linux-nvdimm@lists.01.org>; Fri, 30 Apr 2021 00:28:56 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4FWkWQ6CW9z9t0G; Fri, 30 Apr 2021 17:28:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1619767730;
	bh=gLPJgqKD8Jy0MZ43/eLWhxb9UN2yUXhRzMXzf/L4RqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkK4V86JuRTxdSdg1PNzLWfbnzF5aA3mWq9gSOaJ9zWZq/3VI/3Jamwq9QCbsHUtJ
	 sINIc0FTwhcoOshvMl6yI6RiJdS8BkI5EfMoGSAmP7UqoR9wK6l+au5Aq8IdYJji8l
	 kIHavOtWW6jfirQaLdmCPEPOwknnsqQYYdl1MOwQ=
Date: Fri, 30 Apr 2021 14:27:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v4 0/3] nvdimm: Enable sync-dax property for nvdimm
Message-ID: <YIuHJkwkDiHONYwp@yekko>
References: <161966810162.652.13723419108625443430.stgit@17be908f7c1c>
 <YIrW4bwbR1R0CWm/@stefanha-x1.localdomain>
 <433e352d-5341-520c-5c57-79650277a719@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <433e352d-5341-520c-5c57-79650277a719@linux.ibm.com>
Message-ID-Hash: SEEKZQ4SJVSBGLT43KJ4R3AGRZY2POGB
X-Message-ID-Hash: SEEKZQ4SJVSBGLT43KJ4R3AGRZY2POGB
X-MailFrom: dgibson@ozlabs.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Stefan Hajnoczi <stefanha@redhat.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, groug@kaod.org, qemu-ppc@nongnu.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, peter.maydell@linaro.org, eblake@redhat.com, qemu-arm@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, haozhong.zhang@intel.com, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, armbru@redhat.com, qemu-devel@nongnu.org, linux-nvdimm@lists.01.org, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SEEKZQ4SJVSBGLT43KJ4R3AGRZY2POGB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============3864594649851425914=="


--===============3864594649851425914==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l6FM2Up3jgp91K+8"
Content-Disposition: inline


--l6FM2Up3jgp91K+8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 29, 2021 at 10:02:23PM +0530, Aneesh Kumar K.V wrote:
> On 4/29/21 9:25 PM, Stefan Hajnoczi wrote:
> > On Wed, Apr 28, 2021 at 11:48:21PM -0400, Shivaprasad G Bhat wrote:
> > > The nvdimm devices are expected to ensure write persistence during po=
wer
> > > failure kind of scenarios.
> > >=20
> > > The libpmem has architecture specific instructions like dcbf on POWER
> > > to flush the cache data to backend nvdimm device during normal writes
> > > followed by explicit flushes if the backend devices are not synchrono=
us
> > > DAX capable.
> > >=20
> > > Qemu - virtual nvdimm devices are memory mapped. The dcbf in the guest
> > > and the subsequent flush doesn't traslate to actual flush to the back=
end
> > > file on the host in case of file backed v-nvdimms. This is addressed =
by
> > > virtio-pmem in case of x86_64 by making explicit flushes translating =
to
> > > fsync at qemu.
> > >=20
> > > On SPAPR, the issue is addressed by adding a new hcall to
> > > request for an explicit flush from the guest ndctl driver when the ba=
ckend
> > > nvdimm cannot ensure write persistence with dcbf alone. So, the appro=
ach
> > > here is to convey when the hcall flush is required in a device tree
> > > property. The guest makes the hcall when the property is found, inste=
ad
> > > of relying on dcbf.
> >=20
> > Sorry, I'm not very familiar with SPAPR. Why add a hypercall when the
> > virtio-nvdimm device already exists?
> >=20
>=20
> On virtualized ppc64 platforms, guests use papr_scm.ko kernel drive for
> persistent memory support. This was done such that we can use one kernel
> driver to support persistent memory with multiple hypervisors. To avoid
> supporting multiple drivers in the guest, -device nvdimm Qemu command-line
> results in Qemu using PAPR SCM backend. What this patch series does is to
> make sure we expose the correct synchronous fault support, when we back s=
uch
> nvdimm device with a file.
>=20
> The existing PAPR SCM backend enables persistent memory support with the
> help of multiple hypercall.
>=20
> #define H_SCM_READ_METADATA     0x3E4
> #define H_SCM_WRITE_METADATA    0x3E8
> #define H_SCM_BIND_MEM          0x3EC
> #define H_SCM_UNBIND_MEM        0x3F0
> #define H_SCM_UNBIND_ALL        0x3FC
>=20
> Most of them are already implemented in Qemu. This patch series implements
> H_SCM_FLUSH hypercall.

The overall point here is that we didn't define the hypercall.  It was
defined in order to support NVDIMM/pmem devices under PowerVM.  For
uniformity between PowerVM and KVM guests, we want to support the same
hypercall interface on KVM/qemu as well.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--l6FM2Up3jgp91K+8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCLhyUACgkQbDjKyiDZ
s5LgyhAAlNOzpM9+rzQIM9pfnH1Lo94q3+xqmzvHym9PAdeCUa+jekMI00mK5CRI
buhl3VZG783nan5KYvVEIfblxCN2ENHrcoKM/rVNF6QsGkIQGVfCo1kE2Se1kwZS
dDxcyXK/ASz+ryFQAIUvA5LA2/pyR3AsMVOqCcX9DgZjXm1JZt6dE2byZu8+CJXg
oNlXuJab1+vPwBsMV1tITKUic4Zn1WJQSXZ/sn59uEGW69gG1QK113LQtpLqO1r/
R10btoJgqHquWZMQl807XiDqtLzEs/L+UlKKpmR1uD+jZSRy3L/ir9Rf+QeM4DtL
eGsYndvYaDkxmuE4rtDCxBOMi2GNragtsPOHUuNUd4PaA4K/r0EWpNDHJbcKG04X
boMlF+wiM9EyNZyqa6vlULBkDTvgYA3y8MD0QO+jwHggAOsj8UyBIKn2XascQC+u
mWMJJgeEBgq+IiEhnNj3OfOh5GgJiEUHsRj4FomiAWu125NNN0aNK9uXthhd4DGO
RcekZfaPQOkPJh2WG+ZOAreNqdt6aEaJ95lVXD4l9yYh5Vn29wuon5BmvPEfCroW
wUFAbvJSBiXzIXEggoKnQzsPiG6VPenAHanBVTXvHXHN2InCqcNWdwTw5XgrAKn+
lfTdvqXV93uHpQqbjPiiGMzUGoFsFvQFkvZ6H8NnvOQAS78FXus=
=86vq
-----END PGP SIGNATURE-----

--l6FM2Up3jgp91K+8--

--===============3864594649851425914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============3864594649851425914==--
