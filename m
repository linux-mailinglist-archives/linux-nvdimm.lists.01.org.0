Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CACB12D9682
	for <lists+linux-nvdimm@lfdr.de>; Mon, 14 Dec 2020 11:44:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DC6D7100EF275;
	Mon, 14 Dec 2020 02:44:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=jianchao.wan9@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A5144100EF274
	for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:44:46 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id iq13so6063631pjb.3
        for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=hZ0LuHZeyhaF0bX7xzlPdAGH5qbBkHP5z7Qfn1BZW/c=;
        b=WGy9oZKh2wpdU2Ms6qPOdljQ8B47lfHfFbo+K8jN3cEEyDfxQYIRqqJB6gy87F84XS
         CLhAXyzyQQpFIHK6hWyWUzfLdUqDSyVjmyi5RLfdKgwVUg0ExZq6zABMagKayBmc0n/J
         XDsL0v0zEUTodCt/2jdha4o3hsZREfc6FNwwvtUtNxzTBmgqdcpsobvyQuD8Vsr0lNo3
         jJFB83E/BoJGjQcPwCkPqXBavGQohCyU6+58SaDWpdFaIzNFmHeyD028/DziqzVkscBS
         O1M4T0F31Vi4GoUdOpK1UKrP0VdegPQfXhUiuGglXBOpUcxxuzi56wn/gSEupKBB8mwM
         8F8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=hZ0LuHZeyhaF0bX7xzlPdAGH5qbBkHP5z7Qfn1BZW/c=;
        b=cQVq0Ij6DYo30eZnQA8V9YSjOacdUfXPCOvuJHIdsgSsPNNEG+w4FSVNSE6K11W2HS
         DURJq94iBD+2jVHtXAblU+8qjxGVfhN4u0bUnIvITCue3nIAVjXYZcq+pDre62NHq6gm
         JzJe1mPxqyuOH1OBQb2Cao1OmjLLZXyA/EmleRpEzmJBuNOLw/i3MxIhdGydxBqEyeaR
         wq78mJrb80zUqVS3yPUS27QLjHNhkOtGugGg0FW7hZ6ksEysnvyljqcEPPq19T1e/7xA
         yp68KN0TNdp7DVLePgaKR9aUMGGwEI2Ajr9HKAzwFJxkg7dCpyAoKI3VK6H13Uy07M+M
         zXhQ==
X-Gm-Message-State: AOAM531piEBujvRLfeq8/+46mVynb0ddHx418oY3bo9KgPFOeZYqoxEI
	hLnHogxb8OEmeDW86KD8C6D9t9eNZmY=
X-Google-Smtp-Source: ABdhPJxYUAHCLJctD2rdnq6H4gNUTcPvT1XOuPEiLZOohfEd/ehFCfGV1nbm5sok0E4Gjne6YAP/hg==
X-Received: by 2002:a17:902:8ec4:b029:db:f9ef:564f with SMTP id x4-20020a1709028ec4b02900dbf9ef564fmr6154726plo.19.1607942685628;
        Mon, 14 Dec 2020 02:44:45 -0800 (PST)
Received: from jianchwadeMacBook-Pro.local ([123.108.108.233])
        by smtp.gmail.com with ESMTPSA id 14sm17794896pjm.21.2020.12.14.02.44.44
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 02:44:45 -0800 (PST)
To: linux-nvdimm@lists.01.org
From: Wang Jianchao <jianchao.wan9@gmail.com>
Subject: [HELP] mmap fsdax mode pmem to userland with writethrough
Message-ID: <5a5139ba-6308-4ca4-dc0c-7da271c5c5dc@gmail.com>
Date: Mon, 14 Dec 2020 18:44:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Language: en-US
Message-ID-Hash: UCYIW4DRUKY4FEADGCZXGRTEV3OPWZQE
X-Message-ID-Hash: UCYIW4DRUKY4FEADGCZXGRTEV3OPWZQE
X-MailFrom: jianchao.wan9@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UCYIW4DRUKY4FEADGCZXGRTEV3OPWZQE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi list

We are trying to mmap the file in xfs-dax to userland with writethrough mode,
hope to avoid bandwidth and latency cause by write-allocate in writeback mode
and we can still use the original userland application code w/o using NTstore.

We add following code in the mmap callback of xfs,

vma->vm_page_prot = pgprot_writethrough(vma->vm_page_prot);

But it seems to not work. When I use pcm-memory to check the bandwidth of PMM,
PMM read BW is still there which is nearly equal with PMM write. Even I use
pgprot_noncached, it still not work.

What should I do to implement the writethrough mapping ?

Thanks a million for any help.

Jianchao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
