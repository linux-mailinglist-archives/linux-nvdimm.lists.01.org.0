Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CC321129
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 02:12:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 259282126D822;
	Thu, 16 May 2019 17:12:43 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=jstaron@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4F5A621250448
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 17:12:41 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d30so2351416pgm.7
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 17:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=grI6nIUF/mMOBdv6LrPvHsdNVES0yai/LfFYIZ4bkWY=;
 b=trB5X+v2CFHJR5/h5Ogo8pnGEbixSq/5SbMCfW0BvmcDG2zeRdzxHL4lknPMI8JsaG
 91o9aNowjUtiTckfyBLWY/pZJBmRERl33EcI9dq0zR0lXd+XHl45wImJtwD6qTmBiD3C
 YvIdILOfNr02D208IUOgX7xjB1B80gLQERVK/akSkqvFqS79gmXpU/duephS4OxkvMCj
 iFkaZbcWb+04sJYfOvlYsPNWM7LK/oP8HkDOryS8f1XdKVoMLZUlQ8YVZMbBQiMDnraB
 fYXacmGWn0btEdYeftIv0rPSsHpeCBXpkkAwnfL+k2zqdhfQJ6WS6TGQ7DeGxI98ZyT1
 d5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=grI6nIUF/mMOBdv6LrPvHsdNVES0yai/LfFYIZ4bkWY=;
 b=lixcndgL+UCfyZOXfBTUS2Ms7HNHwrcOx66JJvhDJ6rbME8QATcotA65TumEGt1z4u
 qDeH7rbJq8fgkusZiri+txIiq4AZnRFI99Lapo02SbO6rx17/nVf38SJWByGw5cYh88A
 RC8/IRm/FY8FEZg70juOUzML8yWIOM4zu0i0kB+NEqIARErXdztoog3VZNk7nHrufS+h
 cSl4B7a80xqq/tZ75efz5q2Cf5XQRtMtT8s5UGjlPxrgi2Ujv28HGVSGDinwhnUSwO3v
 hKCsMcg0qIEjmGnLWrx/S5NpDAh5kJlQ87DcTZIof0ifnwivoSV+k5MckF1VAbvEYUyq
 95tw==
X-Gm-Message-State: APjAAAVRqMXJiGi3gEm1QT6WmLZA0V6WWMBO3rCnUHAGctj/r9LZMctV
 j5huVAGSeOSCgGNm0oGd0O/grg==
X-Google-Smtp-Source: APXvYqyv1iVBQbL6jyOdYGu6UtPQiwVBUuqofcSXUoK/ck1DMyLzSDgzGJaT2Ro5WErOmsiHR9V/gQ==
X-Received: by 2002:a63:d816:: with SMTP id b22mr52619479pgh.16.1558051959951; 
 Thu, 16 May 2019 17:12:39 -0700 (PDT)
Received: from jstaron2.mtv.corp.google.com
 ([2620:15c:202:201:b94f:2527:c39f:ca2d])
 by smtp.gmail.com with ESMTPSA id a6sm7245768pgd.67.2019.05.16.17.12.37
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 May 2019 17:12:39 -0700 (PDT)
Subject: Re: [PATCH v9 2/7] virtio-pmem: Add virtio pmem driver
To: Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-acpi@vger.kernel.org, qemu-devel@nongnu.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20190514145422.16923-1-pagupta@redhat.com>
 <20190514145422.16923-3-pagupta@redhat.com>
From: =?UTF-8?Q?Jakub_Staro=c5=84?= <jstaron@google.com>
Message-ID: <c06514fd-8675-ba74-4b7b-ff0eb4a91605@google.com>
Date: Thu, 16 May 2019 17:12:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514145422.16923-3-pagupta@redhat.com>
Content-Language: en-US
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: jack@suse.cz, mst@redhat.com, jasowang@redhat.com, david@fromorbit.com,
 lcapitulino@redhat.com, adilger.kernel@dilger.ca, smbarber@google.com,
 zwisler@kernel.org, aarcange@redhat.com, darrick.wong@oracle.com,
 david@redhat.com, willy@infradead.org, hch@infradead.org, nilal@redhat.com,
 lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com, yuval.shaia@oracle.com,
 stefanha@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, tytso@mit.edu,
 xiaoguangrong.eric@gmail.com, cohuck@redhat.com, rjw@rjwysocki.net,
 imammedo@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/14/19 7:54 AM, Pankaj Gupta wrote:
> +		if (!list_empty(&vpmem->req_list)) {
> +			req_buf = list_first_entry(&vpmem->req_list,
> +					struct virtio_pmem_request, list);
> +			req_buf->wq_buf_avail = true;
> +			wake_up(&req_buf->wq_buf);
> +			list_del(&req_buf->list);
Yes, this change is the right one, thank you!

> +	 /*
> +	  * If virtqueue_add_sgs returns -ENOSPC then req_vq virtual
> +	  * queue does not have free descriptor. We add the request
> +	  * to req_list and wait for host_ack to wake us up when free
> +	  * slots are available.
> +	  */
> +	while ((err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req,
> +					GFP_ATOMIC)) == -ENOSPC) {
> +
> +		dev_err(&vdev->dev, "failed to send command to virtio pmem" \
> +			"device, no free slots in the virtqueue\n");
> +		req->wq_buf_avail = false;
> +		list_add_tail(&req->list, &vpmem->req_list);
> +		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +
> +		/* A host response results in "host_ack" getting called */
> +		wait_event(req->wq_buf, req->wq_buf_avail);
> +		spin_lock_irqsave(&vpmem->pmem_lock, flags);
> +	}
> +	err1 = virtqueue_kick(vpmem->req_vq);
> +	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +
> +	/*
> +	 * virtqueue_add_sgs failed with error different than -ENOSPC, we can't
> +	 * do anything about that.
> +	 */
> +	if (err || !err1) {
> +		dev_info(&vdev->dev, "failed to send command to virtio pmem device\n");
> +		err = -EIO;
> +	} else {
> +		/* A host repsonse results in "host_ack" getting called */
> +		wait_event(req->host_acked, req->done);
> +		err = req->ret;
> +I confirm that the failures I was facing with the `-ENOSPC` error path are not present in v9.

Best,
Jakub Staron
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
