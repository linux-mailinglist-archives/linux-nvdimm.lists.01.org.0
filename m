Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AC41669EA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Feb 2020 22:35:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0F6A310FC3605;
	Thu, 20 Feb 2020 13:36:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7353F10FC3604
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 13:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582234528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2EGDSMUcVYyMIaWsWkgoEGQPIxS78ZmR7hXQG4Kq71Y=;
	b=USEKPshnd/aWyh8CVFEZZi8JRwAE4gUu1oNmcEvHk/mBk6AgQ04lnYJvWCQThEQ/8ufSWB
	GR7/tS/yZVM/0ar3fF7kRv76h6dmSEiz905kN76tm8WF/bqvYEd28spPPJfu4cAwZhKmD+
	GYLNU+8pgHoXk3mhotKF4MTX4TggO2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-uv_izzr0MCWEgLgn0au4Zw-1; Thu, 20 Feb 2020 16:35:23 -0500
X-MC-Unique: uv_izzr0MCWEgLgn0au4Zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EA5D107ACC5;
	Thu, 20 Feb 2020 21:35:22 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 445C85C114;
	Thu, 20 Feb 2020 21:35:18 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept arbitrary offset and len
References: <20200218214841.10076-1-vgoyal@redhat.com>
	<20200218214841.10076-3-vgoyal@redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 20 Feb 2020 16:35:17 -0500
In-Reply-To: <20200218214841.10076-3-vgoyal@redhat.com> (Vivek Goyal's message
	of "Tue, 18 Feb 2020 16:48:35 -0500")
Message-ID: <x49lfoxj622.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: Q7ZZOAH5IZUH3OCHIIH3PCTERXQMKDZB
X-Message-ID-Hash: Q7ZZOAH5IZUH3OCHIIH3PCTERXQMKDZB
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q7ZZOAH5IZUH3OCHIIH3PCTERXQMKDZB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Vivek Goyal <vgoyal@redhat.com> writes:

> Currently pmem_clear_poison() expects offset and len to be sector aligned.
> Atleast that seems to be the assumption with which code has been written.
> It is called only from pmem_do_bvec() which is called only from pmem_rw_page()
> and pmem_make_request() which will only passe sector aligned offset and len.
>
> Soon we want use this function from dax_zero_page_range() code path which
> can try to zero arbitrary range of memory with-in a page. So update this
> function to assume that offset and length can be arbitrary and do the
> necessary alignments as needed.

What caller will try to zero a range that is smaller than a sector?

> nvdimm_clear_poison() seems to assume offset and len to be aligned to
> clear_err_unit boundary. But this is currently internal detail and is
> not exported for others to use. So for now, continue to align offset and
> length to SECTOR_SIZE boundary. Improving it further and to align it
> to clear_err_unit boundary is a TODO item for future.

When there is a poisoned range of persistent memory, it is recorded by
the badblocks infrastructure, which currently operates on sectors.  So,
no matter what the error unit is for the hardware, we currently can't
record/report to userspace anything smaller than a sector, and so that
is what we expect when clearing errors.

Continuing on for completeness, we will currently not map a page with
badblocks into a process' address space.  So, let's say you have 256
bytes of bad pmem, we will tell you we've lost 512 bytes, and even if
you access a valid mmap()d address in the same page as the poisoned
memory, you will get a segfault.

Userspace can fix up the error by calling write(2) and friends to
provide new data, or by punching a hole and writing new data to the hole
(which may result in getting a new block, or reallocating the old block
and zeroing it, which will clear the error).

More comments below...

> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  drivers/nvdimm/pmem.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 075b11682192..e72959203253 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -74,14 +74,28 @@ static blk_status_t pmem_clear_poison(struct pmem_device *pmem,
>  	sector_t sector;
>  	long cleared;
>  	blk_status_t rc = BLK_STS_OK;
> +	phys_addr_t start_aligned, end_aligned;
> +	unsigned int len_aligned;
>  
> -	sector = (offset - pmem->data_offset) / 512;
> +	/*
> +	 * Callers can pass arbitrary offset and len. But nvdimm_clear_poison()
> +	 * expects memory offset and length to meet certain alignment
> +	 * restrction (clear_err_unit). Currently nvdimm does not export
                                                  ^^^^^^^^^^^^^^^^^^^^^^
> +	 * required alignment. So align offset and length to sector boundary

What is "nvdimm" in that sentence?  Because the nvdimm most certainly
does export the required alignment.  Perhaps you meant libnvdimm?

> +	 * before passing it to nvdimm_clear_poison().
> +	 */
> +	start_aligned = ALIGN(offset, SECTOR_SIZE);
> +	end_aligned = ALIGN_DOWN((offset + len), SECTOR_SIZE) - 1;
> +	len_aligned = end_aligned - start_aligned + 1;
> +
> +	sector = (start_aligned - pmem->data_offset) / 512;
>  
> -	cleared = nvdimm_clear_poison(dev, pmem->phys_addr + offset, len);
> -	if (cleared < len)
> +	cleared = nvdimm_clear_poison(dev, pmem->phys_addr + start_aligned,
> +				      len_aligned);
> +	if (cleared < len_aligned)
>  		rc = BLK_STS_IOERR;
>  	if (cleared > 0 && cleared / 512) {
> -		hwpoison_clear(pmem, pmem->phys_addr + offset, cleared);
> +		hwpoison_clear(pmem, pmem->phys_addr + start_aligned, cleared);
>  		cleared /= 512;
>  		dev_dbg(dev, "%#llx clear %ld sector%s\n",
>  				(unsigned long long) sector, cleared,

We could potentially support clearing less than a sector, but I'd have
to understand the use cases better before offerring implementation
suggestions.

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
