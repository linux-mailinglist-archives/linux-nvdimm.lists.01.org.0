Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A60617F5B6
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Mar 2020 12:07:13 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D44D110FC3605;
	Tue, 10 Mar 2020 04:08:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=stefanha@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3542910FC3604
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 04:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583838428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7zCZMOF0iZCujbjrI3iIoDQ/fo/iLP3cIKGJWZDv6zQ=;
	b=aF5RtnC2heSOrftno5P9QHb4JpENAllZQjaOGo8hQjLZgjxLwuu1/kzz0BTEyB/B8Ee1lK
	yP79No738Pg2nwhPewTaDJc14EboZuk1r3+WlvCgtNLIVtMWFg43+plt1BRrs8qPeb9AhP
	6fxDdkZJMR91hbUBDsN8opTeXSf4Dr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-THButNQSMGKrblN1X-wo4A-1; Tue, 10 Mar 2020 07:07:03 -0400
X-MC-Unique: THButNQSMGKrblN1X-wo4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84F6118B5FA7;
	Tue, 10 Mar 2020 11:07:02 +0000 (UTC)
Received: from localhost (unknown [10.36.118.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE82310013A1;
	Tue, 10 Mar 2020 11:06:56 +0000 (UTC)
Date: Tue, 10 Mar 2020 11:06:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 05/20] virtio: Implement get_shm_region for MMIO transport
Message-ID: <20200310110655.GJ140737@stefanha-x1.localdomain>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-6-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200304165845.3081-6-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: W5M7SGGW5Y4YKEJXFHO6QEPQL3NOA2UO
X-Message-ID-Hash: W5M7SGGW5Y4YKEJXFHO6QEPQL3NOA2UO
X-MailFrom: stefanha@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu, dgilbert@redhat.com, mst@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W5M7SGGW5Y4YKEJXFHO6QEPQL3NOA2UO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============3203006390348692132=="

--===============3203006390348692132==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u3bvv0EcKsvvYeex"
Content-Disposition: inline

--u3bvv0EcKsvvYeex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 11:58:30AM -0500, Vivek Goyal wrote:
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>=20
> On MMIO a new set of registers is defined for finding SHM
> regions.  Add their definitions and use them to find the region.
>=20
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> ---
>  drivers/virtio/virtio_mmio.c     | 32 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_mmio.h | 11 +++++++++++
>  2 files changed, 43 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--u3bvv0EcKsvvYeex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5ndM8ACgkQnKSrs4Gr
c8gfygf/do+109aKXm9VFkU/rXC9UEr+hExsP6Lzua5HVq/12kOWyPb6RjeIZfZ/
xpL0jvNcMM2IS72Be3/GddkueGUiN1E44GmjU2+TrXGAh1VzudsId2PJeJfJRsEH
m0WNtnsEQBdeGy5ojXq05pq5yhcq1A7BafE2Fe+mHTDkbB8J/6YtAUzUCIA7Y3m7
2tm9Ju4ERd2cN1Cb9zDCx9eof+ypmPTqaEBF6MYNRuUVhUHhY52ChiWr213rZ2l/
teAcVQZxULQjwnERMuqN/9yupwr7mfZxA3ippJYhHfiAjHks/dA5cIz0xy9jv9/5
kdzLUFXkRegnZVe+HatFmqKOSWXIoA==
=/ks7
-----END PGP SIGNATURE-----

--u3bvv0EcKsvvYeex--

--===============3203006390348692132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============3203006390348692132==--
