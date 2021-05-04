Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86011372448
	for <lists+linux-nvdimm@lfdr.de>; Tue,  4 May 2021 03:44:02 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 55F1F100EB842;
	Mon,  3 May 2021 18:43:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2401:3900:2:1::2; helo=ozlabs.org; envelope-from=dgibson@ozlabs.org; receiver=<UNKNOWN> 
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 352EB100EC1E3
	for <linux-nvdimm@lists.01.org>; Mon,  3 May 2021 18:43:57 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4FZ2gY2NM6z9sT6; Tue,  4 May 2021 11:43:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1620092633;
	bh=3anFEGHjKRDBJBpGN0aquHD3mJDsI32H2+VnbPLeVOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6eZGfba00ncrgKhQYsT9pbqX5+fN+lfIhBajc4eYRtRhC+zBvHTJHxp1ONL2GWvv
	 vL/QusApiUEvubSUSiWvtnxRfO096j++RjpxQ48qp615QNLj3iQSXBpRDrtcHYdweN
	 m2o+noyZ5mUla3ZFvFQ/TuEQXMKerGhdCrtOj+kM=
Date: Tue, 4 May 2021 11:21:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 1/3] spapr: nvdimm: Forward declare and move the
 definitions
Message-ID: <YJChiYgt6AAjhnIe@yekko>
References: <161966810162.652.13723419108625443430.stgit@17be908f7c1c>
 <161966811094.652.571342595267518155.stgit@17be908f7c1c>
 <f33dfff6-a1f7-244f-531e-ef0d93ad0c3d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f33dfff6-a1f7-244f-531e-ef0d93ad0c3d@redhat.com>
Message-ID-Hash: 4CZY5X5DJHTAMYML5KPG3EXJFAL5U7YK
X-Message-ID-Hash: 4CZY5X5DJHTAMYML5KPG3EXJFAL5U7YK
X-MailFrom: dgibson@ozlabs.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, groug@kaod.org, qemu-ppc@nongnu.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com, haozhong.zhang@intel.com, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, armbru@redhat.com, qemu-devel@nongnu.org, aneesh.kumar@linux.ibm.com, linux-nvdimm@lists.01.org, kvm-ppc@vger.kernel.org, shivaprasadbhat@gmail.com, bharata@linux.vnet.ibm.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4CZY5X5DJHTAMYML5KPG3EXJFAL5U7YK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============0314085324446383207=="


--===============0314085324446383207==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rqO14lpZiRldN/l1"
Content-Disposition: inline


--rqO14lpZiRldN/l1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 03, 2021 at 01:23:47PM -0500, Eric Blake wrote:
> On 4/28/21 10:48 PM, Shivaprasad G Bhat wrote:
> > The subsequent patches add definitions which tend to
> > get the compilation to cyclic dependency. So, prepare
> > with forward declarations, move the defitions and clean up.
>=20
> definitions
>=20
> >=20
> > Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> > ---
> >  hw/ppc/spapr_nvdimm.c         |   12 ++++++++++++
> >  include/hw/ppc/spapr_nvdimm.h |   14 ++------------
> >  2 files changed, 14 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> > index b46c36917c..8cf3fb2ffb 100644
> > --- a/hw/ppc/spapr_nvdimm.c
> > +++ b/hw/ppc/spapr_nvdimm.c
> > @@ -31,6 +31,18 @@
> >  #include "qemu/range.h"
> >  #include "hw/ppc/spapr_numa.h"
> > =20
> > +/*
> > + * The nvdimm size should be aligned to SCM block size.
> > + * The SCM block size should be aligned to SPAPR_MEMORY_BLOCK_SIZE
> > + * inorder to have SCM regions not to overlap with dimm memory regions.
>=20
> And while at it, even though it is code motion...

It looks like the patch no longer applies clear to ppc-for-6.1, so can
you rebase and fix up Eric's nitpicks at the same time?

>=20
> > + * The SCM devices can have variable block sizes. For now, fixing the
> > + * block size to the minimum value.
> > + */
> > +#define SPAPR_MINIMUM_SCM_BLOCK_SIZE SPAPR_MEMORY_BLOCK_SIZE
>=20
> > +++ b/include/hw/ppc/spapr_nvdimm.h
> > @@ -11,19 +11,9 @@
> >  #define HW_SPAPR_NVDIMM_H
> > =20
> >  #include "hw/mem/nvdimm.h"
> > -#include "hw/ppc/spapr.h"
> > =20
> > -/*
> > - * The nvdimm size should be aligned to SCM block size.
> > - * The SCM block size should be aligned to SPAPR_MEMORY_BLOCK_SIZE
> > - * inorder to have SCM regions not to overlap with dimm memory regions.
>=20
> ... this should be "in order"
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rqO14lpZiRldN/l1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCQoYcACgkQbDjKyiDZ
s5K2XhAAnKMU4fHKY8zYm2UkdJJMJZJlnQtfgO1iJQLrmfFszhFekavJzaRx/xT0
gudfIWjcqRomM3jzQQq5LbEr/XH4w8ws+PF1kPTetjO7gSQepyO9krepcPmiciJ7
My58zSnBNmyNDAgMHzRc2fYNBFxr/XSXxo2ZZidUavG8fZS2h2ftIz8JlTepY9pN
NBOURrUtwcT+gAvpbE7saAVKLFMlRRFN3vU3Aj/vt/1P5gBg7dOEsYhTleDFDske
njhUdtDB8qy0NZba6Mz0Um6hiUZU/xH+YMS7S1ZZcqA8ne08kTELW5cKzjks1NST
/AAIlrHuFckRzGo3xHeTNeBoU76rZCUWXNe8TxmCswUHOlQQELLspIqbMW2/BgNP
XccFpegH/H/qEwe2ZXVM86aOHuSaIwmKmrF96N5sD0WZMLgRA1XXDSc40p+NV67h
p6uGnKotunrlyHIztASEd+/hwenV6nGAAePeuBP2NLQbD+ZaQRDkzMrTmujN1SRj
u68z8XYYO/pSk77mWO0oh9Ao42EVZVLEOHnRqyjsdc/YD3iLm0QP4hDXe6Q9c39Q
sHXBju4en2BPVJme+8yZzobJzHYXKA3E7wJ0PVx57Ra9KToZf7mZdiL7pHffHI1c
XtqKim8cz5xm4OnCloZTghId9DHNgO9maAHFP+xnroRosQwzD4s=
=tiiy
-----END PGP SIGNATURE-----

--rqO14lpZiRldN/l1--

--===============0314085324446383207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============0314085324446383207==--
