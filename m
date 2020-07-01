Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8164521129B
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Jul 2020 20:26:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CF93D11001ABB;
	Wed,  1 Jul 2020 11:26:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=msnitzer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B6E9D11001AB9
	for <linux-nvdimm@lists.01.org>; Wed,  1 Jul 2020 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1593627978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gM4o34lY2Q2Fu9DNpo9nmnqeENsycpsv4CwD0QpSKRo=;
	b=dbu174cJhKEx2dtUzkFRaS0PVVs75PHM5sdDyGwbWiHhIXTmVlc6PhjLIg5DgqKGgfjgfS
	ZfuLVCKw82obJVkHO1/PAXEd/Sr4lW+z2cF6vjNRvVbbMqWYYzzkL+h0brWAQW+oyqwh04
	huwJyNriiIVu+T5fsBL00HXBRE/hoNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-ve54S7gINvapvHMQrfW7sQ-1; Wed, 01 Jul 2020 14:26:14 -0400
X-MC-Unique: ve54S7gINvapvHMQrfW7sQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EE0A80183C;
	Wed,  1 Jul 2020 18:26:11 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 244BF5C1D3;
	Wed,  1 Jul 2020 18:26:08 +0000 (UTC)
Date: Wed, 1 Jul 2020 13:24:48 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/20] dm: stop using ->queuedata
Message-ID: <20200701172448.GA27528@redhat.com>
References: <20200701085947.3354405-1-hch@lst.de>
 <20200701085947.3354405-11-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200701085947.3354405-11-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: NXKSOL74ZDLY4ZVDDUIY3KAQEGH4K55H
X-Message-ID-Hash: NXKSOL74ZDLY4ZVDDUIY3KAQEGH4K55H
X-MailFrom: msnitzer@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jens Axboe <axboe@kernel.dk>, linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, dm-devel@redhat.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, drbd-dev@lists.linbit.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NXKSOL74ZDLY4ZVDDUIY3KAQEGH4K55H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 01 2020 at  4:59am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Instead of setting up the queuedata as well just use one private data
> field.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
