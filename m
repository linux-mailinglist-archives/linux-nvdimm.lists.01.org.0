Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B2C17F5A1
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Mar 2020 12:04:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9552C10FC3604;
	Tue, 10 Mar 2020 04:05:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=stefanha@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6F5A110FC3604
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 04:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583838288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CzkrWAmBf2oqqeq6nmGCN0dfk2xPizcnlNYu+9BCd+8=;
	b=HTViIH0Kthpq4cdFHoTAA6MXOuj8KNuUNOKwHkRYyHCzxXptdiAxnqQCufdjGRu9DDhLiB
	Xxi/197QGveOEhv6uhMgRlB+pPKsh7P8ld8dsYbLveRF9+zfugvbxPQMYc93e3fEu9OlnY
	9yjy4A1X+8IyGB+4ZgnbLpdyOZaZiW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389--FRRzkK1NtS5nisEDRQ31g-1; Tue, 10 Mar 2020 07:04:45 -0400
X-MC-Unique: -FRRzkK1NtS5nisEDRQ31g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AB9218B5FAA;
	Tue, 10 Mar 2020 11:04:44 +0000 (UTC)
Received: from localhost (unknown [10.36.118.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B404B5C28E;
	Tue, 10 Mar 2020 11:04:38 +0000 (UTC)
Date: Tue, 10 Mar 2020 11:04:37 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 04/20] virtio: Implement get_shm_region for PCI transport
Message-ID: <20200310110437.GI140737@stefanha-x1.localdomain>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-5-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200304165845.3081-5-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: A3ETPCQ24YOFSDX7YA7Q4ZDPYAVGECXI
X-Message-ID-Hash: A3ETPCQ24YOFSDX7YA7Q4ZDPYAVGECXI
X-MailFrom: stefanha@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu, dgilbert@redhat.com, mst@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>, kbuild test robot <lkp@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A3ETPCQ24YOFSDX7YA7Q4ZDPYAVGECXI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============4102709832703086338=="

--===============4102709832703086338==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zgY/UHCnsaNnNXRx"
Content-Disposition: inline

--zgY/UHCnsaNnNXRx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 11:58:29AM -0500, Vivek Goyal wrote:
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_p=
ci_modern.c
> index 7abcc50838b8..52f179411015 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -443,6 +443,111 @@ static void del_vq(struct virtio_pci_vq_info *info)
>  =09vring_del_virtqueue(vq);
>  }
> =20
> +static int virtio_pci_find_shm_cap(struct pci_dev *dev,
> +                                   u8 required_id,
> +                                   u8 *bar, u64 *offset, u64 *len)
> +{
> +=09int pos;
> +
> +        for (pos =3D pci_find_capability(dev, PCI_CAP_ID_VNDR);

Please fix the mixed tabs vs space indentation in this patch.

> +static bool vp_get_shm_region(struct virtio_device *vdev,
> +=09=09=09      struct virtio_shm_region *region, u8 id)
> +{
> +=09struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> +=09struct pci_dev *pci_dev =3D vp_dev->pci_dev;
> +=09u8 bar;
> +=09u64 offset, len;
> +=09phys_addr_t phys_addr;
> +=09size_t bar_len;
> +=09int ret;
> +
> +=09if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> +=09=09return false;
> +=09}
> +
> +=09ret =3D pci_request_region(pci_dev, bar, "virtio-pci-shm");
> +=09if (ret < 0) {
> +=09=09dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
> +=09=09=09__func__);
> +=09=09return false;
> +=09}
> +
> +=09phys_addr =3D pci_resource_start(pci_dev, bar);
> +=09bar_len =3D pci_resource_len(pci_dev, bar);
> +
> +        if (offset + len > bar_len) {
> +                dev_err(&pci_dev->dev,
> +                        "%s: bar shorter than cap offset+len\n",
> +                        __func__);
> +                return false;
> +        }
> +
> +=09region->len =3D len;
> +=09region->addr =3D (u64) phys_addr + offset;
> +
> +=09return true;
> +}

Missing pci_release_region()?

--zgY/UHCnsaNnNXRx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5ndEUACgkQnKSrs4Gr
c8jLYwf/exeUl3WphEdcCDBZB1FzUfCmswGzkwrT92YXIdpwgJZrl688mmhjXloi
GJqsnE3BX20JSmDOw3KlRiByhAEaz2HwKpdjT62Xq3CBRMLDemAymoDsGtjlanVK
fdmw17AJzX01wpcPW2ek87jGaHwygYHt4GFrE9NH+TiB7WVU0EfXmaF1fbVREkT1
VGzPZqY0xpWl3g12g9P0BCrftqa0PyLG29aHHG5NFs7kbTNaej5NcBOUjxEvk9jB
3mS+w/vUz7cdZPyj0BxxVjNN6udpyi83i4QdTzgLKilwD9x1VhvtnVVJiOdXOdvm
h4bns2UcpEqEvyaSsVzo3jlYx+OeRw==
=74o7
-----END PGP SIGNATURE-----

--zgY/UHCnsaNnNXRx--

--===============4102709832703086338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============4102709832703086338==--
