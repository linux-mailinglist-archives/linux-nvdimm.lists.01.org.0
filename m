Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA41210C76
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Jul 2020 15:43:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 29882114726D0;
	Wed,  1 Jul 2020 06:43:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=axboe@kernel.dk; receiver=<UNKNOWN> 
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A15F6114726CB
	for <linux-nvdimm@lists.01.org>; Wed,  1 Jul 2020 06:43:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id bj10so4706932plb.11
        for <linux-nvdimm@lists.01.org>; Wed, 01 Jul 2020 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mp3kZB+WljYlToUgRKHu/jMatrXibHPg1FspuaVdS+E=;
        b=dYwQW22jG+1U/8wxe99npchEcHOVVxkAEfKn6EBHer8enDnZPRaJ5nzspLL5jxwR7E
         8c6AvaHExACDpMcSpNKAKYnhHPOqDFAuRaNYxN8Hxrsw/QZbGOrdK0NOggJHl9AxSJgs
         BdPFufpE696CTqP0ZSQJiMeB/Vf1M790yE0S6UfvzUcW/2LK3Cll1WaQxPF72JBBNiAi
         uNmww608IStODIzkXWWB+ivDstxmDBFHqxk0XqSa0PCNUdKh4Ts6OZk4XhvUDLi977z9
         tRq/B+DQOlpjSRZ9yIK6lLqMnhcWWTEtAYB9JXJiCaKrLlWYMNjb0yZxPI5ky8TpWAqd
         O5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mp3kZB+WljYlToUgRKHu/jMatrXibHPg1FspuaVdS+E=;
        b=UO6PvVwrA4PRId/H3FpluaORdyuxj4phIcgyXz67mIDw0wKdBXKddq8jJgUeieq+eP
         as/ZWmIopHA8jEBfLhXw4snip41tMDpqEgFrnbONUmPG5nu6VmWjqNBGmvW7f4FmX1VH
         rhuzyFF6PzBSI1aIoaNlMP5yKnzAy2ah9rYdxFpZvaNF5439uTP3by3PVK3MUTTdQDmL
         Nf4ldgqh+SHdkIypRyd9yBKaB1l3rwVq84skg+/7QByDivQyI7twpzjaXt8H/rXLPAAV
         ztaBnVFuDgeQU2a9Gsg8bmk8CRwxZAAk19TvUN6uSgPPHXS24pHh+7Lcb1ZNlCJJi1Rf
         G7JA==
X-Gm-Message-State: AOAM531RzlVVBm3y0iE/nb/O1vlp8HOa+ZSmYQVoya75YDKPPuQMz4Lt
	c//dv2HNQbFW/8HXCmmH+Acc4w==
X-Google-Smtp-Source: ABdhPJwvetMLus+odkxVKs2TAwFJf3HuNkqQjK/vuqbHNuGPdXyOvoQGErv/SGur7kel3VcwfskpPQ==
X-Received: by 2002:a17:902:690b:: with SMTP id j11mr14712438plk.313.1593611011686;
        Wed, 01 Jul 2020 06:43:31 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:64c1:67b1:df51:2fa8? ([2605:e000:100e:8c61:64c1:67b1:df51:2fa8])
        by smtp.gmail.com with ESMTPSA id g4sm5868990pfi.68.2020.07.01.06.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 06:43:31 -0700 (PDT)
Subject: Re: rename ->make_request_fn and move it to the
 block_device_operations v2
To: Christoph Hellwig <hch@lst.de>
References: <20200701085947.3354405-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bffb89d5-b51a-5f5a-15f4-b891f1f053ef@kernel.dk>
Date: Wed, 1 Jul 2020 07:43:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701085947.3354405-1-hch@lst.de>
Content-Language: en-US
Message-ID-Hash: 7T5MO6AGTTMM3BLXCOOA6MY355NGVZNV
X-Message-ID-Hash: 7T5MO6AGTTMM3BLXCOOA6MY355NGVZNV
X-MailFrom: axboe@kernel.dk
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7T5MO6AGTTMM3BLXCOOA6MY355NGVZNV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 7/1/20 2:59 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series moves the make_request_fn method into block_device_operations
> with the much more descriptive ->submit_bio name.  It then also gives
> generic_make_request a more descriptive name, and further optimize the
> path to issue to blk-mq, removing the need for the direct_make_request
> bypass.

Thanks, I'll try this again.

-- 
Jens Axboe
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
