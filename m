Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE231B51C0
	for <lists+linux-nvdimm@lfdr.de>; Tue, 17 Sep 2019 17:44:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 62D1F21962301;
	Tue, 17 Sep 2019 08:44:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 76BFA2020F93E
 for <linux-nvdimm@lists.01.org>; Tue, 17 Sep 2019 08:44:01 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id s28so3485291otd.4
 for <linux-nvdimm@lists.01.org>; Tue, 17 Sep 2019 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=45gXoY2Cg/44HhhNb7rJKvkv2hH8MBED76Bb0Rufv4M=;
 b=f8acdOxWhzyHmU+TpKIL4WhFjxccip8lR0TE6gH03ZJ9LBc6k9fKVMxjjQcDp/VgWb
 UMTJYaNcggB74te7gjcgjxCc1Tofs5jp9VGXKWbSnoQdGmfT4hoJLMcSV4Ij0KHvXZyZ
 ABhtPtd6QDk4hHivhhaAasyBIBARQrKYM2A7DClL+m8wPVb++d+Usplu4lVoA6E15z9A
 pT7CovdcAlFdu9BD636VocYBxOkqAEwLRHDvGM08l5LCzjmDwe/JiPsLQ8iDz/5zSODU
 Hf4czDF2uwk+jQ7rviXex48z2Iic2+dCzjAAhG8Yea0cP1yYvmM2rTnG0QdXLHrxKlrt
 zKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=45gXoY2Cg/44HhhNb7rJKvkv2hH8MBED76Bb0Rufv4M=;
 b=SkTpgjBe5Wkzq+bE8M3AqL7YsYvKwQwum2ktN9NJohs2ryYN4jF4tIpk9tIUcGonVb
 74CPFPDzTrcL14SZBIMdzSN+UmwMHtbbLtBR6u+uPJFyjKesRuJKkspmzrx5QOLeaEdH
 dP8yebBYLcitL9lOUWvt5GDPH1jDHwDKsFNClU8LUIkeNCQEnQwmKpy+0lbENYzGsUDV
 Gx8mmEI3JNQjTygfNs9KC+3bAddpclepoXQylD8HJoSpThQQlrbe8X/S9YWapV39+wBt
 pc/AXSWmD/GhoMGL8wQr+I5SUCMBm+JnVgQG4HgJjhBQ+Up+WVwsoISdEw9VIQ4IusUj
 Ocjw==
X-Gm-Message-State: APjAAAUibucZ/DZnI2oP0OrfgqQV535ZlKC+8EEccFe+QFwgoV7Fxefi
 yDSnocrrxbZnXL2NLVuCcyu/495DDobKomDz7Ff8Lqzb
X-Google-Smtp-Source: APXvYqy2LWlbVYTlNQ+WGB88Z4DKLCVaaOJjC5RXXSSn75wG1Mmr1fScjQBpKF7yWgpVIpUXlq8BQm1YHloMJd88AKk=
X-Received: by 2002:a9d:3a6:: with SMTP id f35mr3397396otf.363.1568735079251; 
 Tue, 17 Sep 2019 08:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190917152824.12306-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190917152824.12306-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 17 Sep 2019 08:44:28 -0700
Message-ID: <CAPcyv4hwGwrkecngo4wDzKnhpHvaMEPUAmtb0UAdnEvbDxeESA@mail.gmail.com>
Subject: Re: [PATCH v6] libnvdimm: Fix endian conversion issues
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Sep 17, 2019 at 8:28 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> nd_label->dpa issue was observed when trying to enable the namespace created
> with little-endian kernel on a big-endian kernel. That made me run
> `sparse` on the rest of the code and other changes are the result of that.
>
> Fixes: d9b83c756953 ("libnvdimm, btt: rework error clearing")
> Fixes: 9dedc73a4658 ("libnvdimm/btt: Fix LBA masking during 'free list' population")
>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
> Changes from v5:
> * update commit subject

Thanks I have this one queued was just waiting to finalize my tree
with the answer to the question about the crash fix.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
