Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7557365313
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 09:19:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 49CA5100EB859;
	Tue, 20 Apr 2021 00:19:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.32.121.110; helo=1.mo51.mail-out.ovh.net; envelope-from=groug@kaod.org; receiver=<UNKNOWN> 
Received: from 1.mo51.mail-out.ovh.net (1.mo51.mail-out.ovh.net [178.32.121.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ABA63100EB859
	for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 00:19:30 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.72])
	by mo51.mail-out.ovh.net (Postfix) with ESMTPS id DD7D0282FA1;
	Tue, 20 Apr 2021 09:19:26 +0200 (CEST)
Received: from kaod.org (37.59.142.106) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Apr
 2021 09:19:26 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-106R006e0384a78-5e6d-4b83-a0a2-258cc1ae5f18,
                    F8484F3EE3345E552A9359E6756AA457A7210C68) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Tue, 20 Apr 2021 09:19:25 +0200
From: Greg Kurz <groug@kaod.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH v3 1/3] dax: Add an enum for specifying dax
 wakup mode
Message-ID: <20210420091925.08054e8b@bahia.lan>
In-Reply-To: <20210419213636.1514816-2-vgoyal@redhat.com>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
	<20210419213636.1514816-2-vgoyal@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 4fd4651b-4865-4921-847a-6cdede9f3c7e
X-Ovh-Tracer-Id: 9258837884391430447
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvddthedguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehvihhrthhiohdqfhhssehrvgguhhgrthdrtghomh
Message-ID-Hash: UYGT5FPPFT6KTQF7HXBHOFTTTLVY7HWI
X-Message-ID-Hash: UYGT5FPPFT6KTQF7HXBHOFTTTLVY7HWI
X-MailFrom: groug@kaod.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, jack@suse.cz, willy@infradead.org, linux-nvdimm@lists.01.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, virtio-fs@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UYGT5FPPFT6KTQF7HXBHOFTTTLVY7HWI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 19 Apr 2021 17:36:34 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> Dan mentioned that he is not very fond of passing around a boolean true/false
> to specify if only next waiter should be woken up or all waiters should be
> woken up. He instead prefers that we introduce an enum and make it very
> explicity at the callsite itself. Easier to read code.
> 
> This patch should not introduce any change of behavior.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  fs/dax.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index b3d27fdc6775..00978d0838b1 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -144,6 +144,16 @@ struct wait_exceptional_entry_queue {
>  	struct exceptional_entry_key key;
>  };
>  
> +/**
> + * enum dax_entry_wake_mode: waitqueue wakeup toggle
> + * @WAKE_NEXT: entry was not mutated
> + * @WAKE_ALL: entry was invalidated, or resized
> + */
> +enum dax_entry_wake_mode {
> +	WAKE_NEXT,
> +	WAKE_ALL,
> +};
> +
>  static wait_queue_head_t *dax_entry_waitqueue(struct xa_state *xas,
>  		void *entry, struct exceptional_entry_key *key)
>  {
> @@ -182,7 +192,8 @@ static int wake_exceptional_entry_func(wait_queue_entry_t *wait,
>   * The important information it's conveying is whether the entry at
>   * this index used to be a PMD entry.
>   */
> -static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
> +static void dax_wake_entry(struct xa_state *xas, void *entry,
> +			   enum dax_entry_wake_mode mode)
>  {
>  	struct exceptional_entry_key key;
>  	wait_queue_head_t *wq;
> @@ -196,7 +207,7 @@ static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
>  	 * must be in the waitqueue and the following check will see them.
>  	 */
>  	if (waitqueue_active(wq))
> -		__wake_up(wq, TASK_NORMAL, wake_all ? 0 : 1, &key);
> +		__wake_up(wq, TASK_NORMAL, mode == WAKE_ALL ? 0 : 1, &key);
>  }
>  
>  /*
> @@ -268,7 +279,7 @@ static void put_unlocked_entry(struct xa_state *xas, void *entry)
>  {
>  	/* If we were the only waiter woken, wake the next one */
>  	if (entry && !dax_is_conflict(entry))
> -		dax_wake_entry(xas, entry, false);
> +		dax_wake_entry(xas, entry, WAKE_NEXT);
>  }
>  
>  /*
> @@ -286,7 +297,7 @@ static void dax_unlock_entry(struct xa_state *xas, void *entry)
>  	old = xas_store(xas, entry);
>  	xas_unlock_irq(xas);
>  	BUG_ON(!dax_is_locked(old));
> -	dax_wake_entry(xas, entry, false);
> +	dax_wake_entry(xas, entry, WAKE_NEXT);
>  }
>  
>  /*
> @@ -524,7 +535,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
>  
>  		dax_disassociate_entry(entry, mapping, false);
>  		xas_store(xas, NULL);	/* undo the PMD join */
> -		dax_wake_entry(xas, entry, true);
> +		dax_wake_entry(xas, entry, WAKE_ALL);
>  		mapping->nrexceptional--;
>  		entry = NULL;
>  		xas_set(xas, index);
> @@ -937,7 +948,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
>  	xas_lock_irq(xas);
>  	xas_store(xas, entry);
>  	xas_clear_mark(xas, PAGECACHE_TAG_DIRTY);
> -	dax_wake_entry(xas, entry, false);
> +	dax_wake_entry(xas, entry, WAKE_NEXT);
>  
>  	trace_dax_writeback_one(mapping->host, index, count);
>  	return ret;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
