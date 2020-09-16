Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE45026C2F8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 14:52:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B4FF4144CFAB1;
	Wed, 16 Sep 2020 05:52:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=richard.weiyang@linux.alibaba.com; receiver=<UNKNOWN> 
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2D233144CFAA9
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 05:52:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0U97x1PB_1600260761;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U97x1PB_1600260761)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Sep 2020 20:52:41 +0800
Date: Wed, 16 Sep 2020 20:52:41 +0800
From: Wei Yang <richard.weiyang@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 7/8] xen/balloon: try to merge system ram resources
Message-ID: <20200916125241.GA48127@L-31X9LVDL-1304.local>
References: <20200911103459.10306-1-david@redhat.com>
 <20200911103459.10306-8-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200911103459.10306-8-david@redhat.com>
Message-ID-Hash: YFS33AIEZIYT36ZAK45ZVVRCXSJZWIYT
X-Message-ID-Hash: YFS33AIEZIYT36ZAK45ZVVRCXSJZWIYT
X-MailFrom: richard.weiyang@linux.alibaba.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>, Andrew Morton <akpmt@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <sstabellini@kernel.org>, Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>, Julien Grall <julien@xen.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YFS33AIEZIYT36ZAK45ZVVRCXSJZWIYT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2020 at 12:34:58PM +0200, David Hildenbrand wrote:
>Let's try to merge system ram resources we add, to minimize the number
>of resources in /proc/iomem. We don't care about the boundaries of
>individual chunks we added.
>
>Reviewed-by: Juergen Gross <jgross@suse.com>
>Cc: Andrew Morton <akpmt@linux-foundation.org>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>Cc: Juergen Gross <jgross@suse.com>
>Cc: Stefano Stabellini <sstabellini@kernel.org>
>Cc: Roger Pau Monn=E9 <roger.pau@citrix.com>
>Cc: Julien Grall <julien@xen.org>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Cc: Baoquan He <bhe@redhat.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/xen/balloon.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
>index 9f40a294d398d..b57b2067ecbfb 100644
>--- a/drivers/xen/balloon.c
>+++ b/drivers/xen/balloon.c
>@@ -331,7 +331,7 @@ static enum bp_state reserve_additional_memory(void)
> 	mutex_unlock(&balloon_mutex);
> 	/* add_memory_resource() requires the device_hotplug lock */
> 	lock_device_hotplug();
>-	rc =3D add_memory_resource(nid, resource, MHP_NONE);
>+	rc =3D add_memory_resource(nid, resource, MEMHP_MERGE_RESOURCE);
> 	unlock_device_hotplug();
> 	mutex_lock(&balloon_mutex);
>=20
>--=20
>2.26.2

--=20
Wei Yang
Help you, Help me
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
