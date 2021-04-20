Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C22365352
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 09:34:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7474E100EB342;
	Tue, 20 Apr 2021 00:34:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.137.123.220; helo=smtpout1.3005.mail-out.ovh.net; envelope-from=groug@kaod.org; receiver=<UNKNOWN> 
Received: from smtpout1.3005.mail-out.ovh.net (smtpout1.mo3005.mail-out.ovh.net [79.137.123.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 26B8C100EB33F
	for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 00:34:24 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.144])
	by mo3005.mail-out.ovh.net (Postfix) with ESMTPS id 41356141A27;
	Tue, 20 Apr 2021 07:34:22 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Apr
 2021 09:34:21 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-100R003ff1e15fc-d96d-46c0-9a30-b0f5e4c29b11,
                    F8484F3EE3345E552A9359E6756AA457A7210C68) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Tue, 20 Apr 2021 09:34:20 +0200
From: Greg Kurz <groug@kaod.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to
 put_unlocked_entry()
Message-ID: <20210420093420.2eed3939@bahia.lan>
In-Reply-To: <20210419213636.1514816-3-vgoyal@redhat.com>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
	<20210419213636.1514816-3-vgoyal@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 895b2bce-2bc7-4d1b-86ac-94b14387f467
X-Ovh-Tracer-Id: 9511039463505303855
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvddthedguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehvihhrthhiohdqfhhssehrvgguhhgrthdrtghomh
Message-ID-Hash: OVTQEEKTUWVACTHDSD62J5Z57RBCUH3I
X-Message-ID-Hash: OVTQEEKTUWVACTHDSD62J5Z57RBCUH3I
X-MailFrom: groug@kaod.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, jack@suse.cz, willy@infradead.org, linux-nvdimm@lists.01.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, virtio-fs@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OVTQEEKTUWVACTHDSD62J5Z57RBCUH3I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 19 Apr 2021 17:36:35 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> As of now put_unlocked_entry() always wakes up next waiter. In next
> patches we want to wake up all waiters at one callsite. Hence, add a
> parameter to the function.
> 
> This patch does not introduce any change of behavior.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/dax.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 00978d0838b1..f19d76a6a493 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -275,11 +275,12 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
>  	finish_wait(wq, &ewait.wait);
>  }
>  
> -static void put_unlocked_entry(struct xa_state *xas, void *entry)
> +static void put_unlocked_entry(struct xa_state *xas, void *entry,
> +			       enum dax_entry_wake_mode mode)
>  {
>  	/* If we were the only waiter woken, wake the next one */

With this change, the comment is no longer accurate since the
function can now wake all waiters if passed mode == WAKE_ALL.
Also, it paraphrases the code which is simple enough, so I'd
simply drop it.

This is minor though and it shouldn't prevent this fix to go
forward.

Reviewed-by: Greg Kurz <groug@kaod.org>

>  	if (entry && !dax_is_conflict(entry))
> -		dax_wake_entry(xas, entry, WAKE_NEXT);
> +		dax_wake_entry(xas, entry, mode);
>  }
>  
>  /*
> @@ -633,7 +634,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
>  			entry = get_unlocked_entry(&xas, 0);
>  		if (entry)
>  			page = dax_busy_page(entry);
> -		put_unlocked_entry(&xas, entry);
> +		put_unlocked_entry(&xas, entry, WAKE_NEXT);
>  		if (page)
>  			break;
>  		if (++scanned % XA_CHECK_SCHED)
> @@ -675,7 +676,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
>  	mapping->nrexceptional--;
>  	ret = 1;
>  out:
> -	put_unlocked_entry(&xas, entry);
> +	put_unlocked_entry(&xas, entry, WAKE_NEXT);
>  	xas_unlock_irq(&xas);
>  	return ret;
>  }
> @@ -954,7 +955,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
>  	return ret;
>  
>   put_unlocked:
> -	put_unlocked_entry(xas, entry);
> +	put_unlocked_entry(xas, entry, WAKE_NEXT);
>  	return ret;
>  }
>  
> @@ -1695,7 +1696,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
>  	/* Did we race with someone splitting entry or so? */
>  	if (!entry || dax_is_conflict(entry) ||
>  	    (order == 0 && !dax_is_pte_entry(entry))) {
> -		put_unlocked_entry(&xas, entry);
> +		put_unlocked_entry(&xas, entry, WAKE_NEXT);
>  		xas_unlock_irq(&xas);
>  		trace_dax_insert_pfn_mkwrite_no_entry(mapping->host, vmf,
>  						      VM_FAULT_NOPAGE);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
