Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818AE20F66D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 15:57:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BDDD111427DB7;
	Tue, 30 Jun 2020 06:57:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=axboe@kernel.dk; receiver=<UNKNOWN> 
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0D58A11427DB4
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 06:57:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x8so7614561plm.10
        for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6WoGClip/9lIMADlW96b66URAMpf8agavloV0J0+6z0=;
        b=NpTXHg4eLKIDB3B017yOQCnwb3dBSkBllVoAHChdp1FGoCyQ19eq1VXevMLSrM/lhD
         bQk0yrTpC1Irq2MNTGh49jfpD7zqgiVbJtqJYeruoqyJ31uUsOmkXd433JMWP+NtSVov
         ZzGBWe4xhNJRj47E5aARYY/9uUmyXWiWjg1l6pljN4nXRLoWQN1OJ6HHzWlN6uNS1Lvc
         bcrSTvkHyH7MDnkYvBu1O0JOQIAWVJgUutILN7WG8Di8qKlewR28Ariy+ojttBxfAl/B
         FxzoT9uIuyEQaP+UAHq4/tgN7PJVGPmfXaxyS6AW/qEEAuiLEhHfUD+LyDQfCVGwqwpj
         3wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6WoGClip/9lIMADlW96b66URAMpf8agavloV0J0+6z0=;
        b=pn0+nP7bC7Gk4BP3YcjWprH1D8P8zI+x1roEkgrWetIP+1P24cCUaY6nYkoBjoMH5s
         DJ3FWrGrn6qsUGGfDAF66TCUzcm0U1k/UW1KoPN3M2fTV7C2zoib5QqT72jaIyuHvoMt
         DH+ai5qSVruuR4Wfyw9scmP0AGq300nQVTy15dC3s05+jaDzcJZgn2HW9myIfFHS7FiO
         DPuhhzI3m5Kgg27ThLK05QtuOo8fEhUz9NVbnmsfdRxj/N7N8gGRm0aC/cBIzQO8Kkkn
         QnPVADmOWDt1jG/ZnFBPjEsdHRA+o5L2Ju9GlbtB4ojy2E7RuN30C6fqjsYwXiiBuUdb
         1vBA==
X-Gm-Message-State: AOAM530DHHRHlnVxXADGmd6q58D+5AYLXznkoog9VGZkxFs6a6LXgyN9
	3KgLE1pZiCExxajUDkvFYdacBA==
X-Google-Smtp-Source: ABdhPJxkJrJtaSOyTXzA8zW0V7qLT6cuFQyL+FUGsc5/cLMGVxoMFOJShXuR+F2LWbUj8PAuD022LQ==
X-Received: by 2002:a17:90a:ec13:: with SMTP id l19mr20004827pjy.81.1593525452289;
        Tue, 30 Jun 2020 06:57:32 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4113:50ea:3eb3:a39b? ([2605:e000:100e:8c61:4113:50ea:3eb3:a39b])
        by smtp.gmail.com with ESMTPSA id m140sm2896019pfd.195.2020.06.30.06.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 06:57:31 -0700 (PDT)
Subject: Re: rename ->make_request_fn and move it to the
 block_device_operations
To: Christoph Hellwig <hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bd1443c0-be37-115b-1110-df6f0e661a50@kernel.dk>
Date: Tue, 30 Jun 2020 07:57:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629193947.2705954-1-hch@lst.de>
Content-Language: en-US
Message-ID-Hash: VA27LGT3OSWWFHB5EGLUIRSDOBV4Z4SQ
X-Message-ID-Hash: VA27LGT3OSWWFHB5EGLUIRSDOBV4Z4SQ
X-MailFrom: axboe@kernel.dk
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: dm-devel@redhat.com, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VA27LGT3OSWWFHB5EGLUIRSDOBV4Z4SQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 6/29/20 1:39 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series moves the make_request_fn method into block_device_operations
> with the much more descriptive ->submit_bio name.  It then also gives
> generic_make_request a more descriptive name, and further optimize the
> path to issue to blk-mq, removing the need for the direct_make_request
> bypass.

Looks good to me, and it's a nice cleanup as well. Applied.

-- 
Jens Axboe
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
