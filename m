Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 806DF169BBD
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 02:24:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BCDA210FC337D;
	Sun, 23 Feb 2020 17:24:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=yi.zhang@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C401310FC3376
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 17:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582507438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C8JUnLh89M4fi7B5JYgxQ+iHa3guaoKzTWzA8Cq+bHk=;
	b=NtUwOm9zILxL73UNxLdF3ENnBHI8Bs4hYvSsSa0WR28VvMcRd4Mk/AzKFD2JZu94Hw0F6Z
	3RGckglJUpU+7yqxcA9WGARqxpnedkfcinPnpCo7Oc6u8QW2IeWcF0anfKnp/uTTACUo+A
	xxEogJGiLGArpFLKoy9C3dZsCm9lwG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-4E8PyZmEOp2GT8nmNgn5gw-1; Sun, 23 Feb 2020 20:23:54 -0500
X-MC-Unique: 4E8PyZmEOp2GT8nmNgn5gw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9F828017CC;
	Mon, 24 Feb 2020 01:23:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-24.pek2.redhat.com [10.72.12.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 222898B755;
	Mon, 24 Feb 2020 01:23:50 +0000 (UTC)
Subject: Re: [PATCH 02/30] dax: Add missing annotations ofr dax_read_lock()
 and dax_read_unlock()
To: Jules Irenge <jbi.octave@gmail.com>, boqun.feng@gmail.com
References: <0/30> <20200223231711.157699-1-jbi.octave@gmail.com>
 <20200223231711.157699-3-jbi.octave@gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <dddff25c-9716-74f4-7fdb-c6b8f849e8f4@redhat.com>
Date: Mon, 24 Feb 2020 09:23:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200223231711.157699-3-jbi.octave@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: 4TYU4AGOR34B6PUXG2Z72VVQ7TCYZ7X2
X-Message-ID-Hash: 4TYU4AGOR34B6PUXG2Z72VVQ7TCYZ7X2
X-MailFrom: yi.zhang@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, "open list:DEVICE DIRECT ACCESS DAX" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4TYU4AGOR34B6PUXG2Z72VVQ7TCYZ7X2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit



On 2/24/20 7:16 AM, Jules Irenge wrote:
> Sparse reports warning at dax_read_lock() and at dax_read_unlock()
>
> warning: context imbalance in dax_read_lock() - wrong count at exit
>   warning: context imbalance in dax_read_unlock() - unexpected unlock
>
> The root cause is the mnissing annotations at dax_read_lock()
> 	and dax_read_unlock()
s/mnissing/missing
> Add the missing __acquires(&dax_srcu) notations to dax_read_lock()
> Add the missing __releases(&dax_srcu) annotation to dax_read_unlock()
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>   drivers/dax/super.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 26a654dbc69a..f872a2fb98d4 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -28,13 +28,13 @@ static struct super_block *dax_superblock __read_mostly;
>   static struct hlist_head dax_host_list[DAX_HASH_SIZE];
>   static DEFINE_SPINLOCK(dax_host_lock);
>   
> -int dax_read_lock(void)
> +int dax_read_lock(void) __acquires(&dax_srcu)
>   {
>   	return srcu_read_lock(&dax_srcu);
>   }
>   EXPORT_SYMBOL_GPL(dax_read_lock);
>   
> -void dax_read_unlock(int id)
> +void dax_read_unlock(int id) __releases(&dax_srcu)
>   {
>   	srcu_read_unlock(&dax_srcu, id);
>   }
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
