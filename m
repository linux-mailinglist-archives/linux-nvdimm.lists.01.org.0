Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEB02E3B2
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 May 2019 19:44:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 55CD62128D893;
	Wed, 29 May 2019 10:44:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1F6C421275441
 for <linux-nvdimm@lists.01.org>; Wed, 29 May 2019 10:44:05 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id l17so2924309otq.1
 for <linux-nvdimm@lists.01.org>; Wed, 29 May 2019 10:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lDQn3yreMIvkhDNvoP3xfD/r68+B2Q+7Ne6HDwVGAaw=;
 b=avnFDm//6aZlywpTAgVQcj98TI1FMYCEcsJ6wl5LOMip+pY2kfF7YE58snentvMS+N
 4CPXW4ZM0TDbUL6l6ELQVdbT6kHIHgXNXnrfJqDAzStC4RPRmDoikpfkYG1sNFPpvmrv
 d8/+Bpw34wsePxRFcsMEfDxfQpPoSJD4veyL9yVc2VAfP7nLI97xADep8DXaTCUQtg5M
 QAFXwSwAqkrYaToZ3K0V0PCqA47xhXf1HE64v8NLFSRIakALGcpz0w9852Z6UvWXgV7m
 EoSaAgZAzoCsyGiPQsut5/yFZaLvO9MiYIAbt4McaFMXr49bOUlZLAarYvnSXMehmoxH
 C79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lDQn3yreMIvkhDNvoP3xfD/r68+B2Q+7Ne6HDwVGAaw=;
 b=m+TvfV1Vxe8FK/kGsgag5zBEoWFyvq5kPTGmnDUah0BVQQ7EHSUZ04J00FRnjHZbfg
 llmBt5iiDTqtuZcR0RPQ9BTi+zD7UMPiZ0tpG+LPJ28+r0a5j0oF9lAaMVaGiMdQzq6j
 ByoLxIwsYYBVcQ4/z/jLXjUbwTtr/bnP5n9hzEP3h5xh4PI2jP5gWjS408yGtnQXiD2u
 Vme+1hzfm/kxYVCKzymRjraePnnoZaCdOS+jf1yPPMEtg57JEgIOmFhH8+s9rCL64Eac
 GGhTK9R174vyq+K97WKz49FsK+aJusQ2E9rlLSNRZ4CLT84VWtAQKDNyFPcbTeRY8IaB
 EY7w==
X-Gm-Message-State: APjAAAUssxO6y9T1c7qsgh7yExpSN0w2MNt/noAYLQwyTchZuAR+vd/l
 nFrPA2RHAe/gBghcpNHAFpDiGssAfzZSNFLnKlzXHdSEZMA=
X-Google-Smtp-Source: APXvYqzWJolrR6y2f5vHM+6Ri4bdtGM8Y0fWqHHmjJFlRvqmk8GqWo59B3KRJaJCDE7xJ4RzCr8LeGqU6HgcPgS2Nmo=
X-Received: by 2002:a05:6830:1182:: with SMTP id
 u2mr30215546otq.71.1559151844604; 
 Wed, 29 May 2019 10:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190528222440.30392-1-vishal.l.verma@intel.com>
 <20190528222440.30392-7-vishal.l.verma@intel.com>
In-Reply-To: <20190528222440.30392-7-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 29 May 2019 10:43:53 -0700
Message-ID: <CAPcyv4izGNU8iDmnqH1k7CU0iHXqVUpd5YjXGAL4a9UM65geow@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 06/10] libdaxctl: add an interface to get the
 mode for a dax device
To: Vishal Verma <vishal.l.verma@intel.com>
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 28, 2019 at 3:24 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> In preparation for a reconfigure-device command, add an interface to
> retrieve the 'mode' of a dax device. This will allow the
> reconfigure-device command (and via daxctl_dev_to_json()), also
> daxctl-list) to print the mode on device listings via a list command or
> immediately after a mode change.
>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Hmm, if we add a daxctl_dev_get_memory() helper to retrieve a context
for doing kmem-related operations could that be a stand-in for
daxctl_dev_get_mode()? I.e. "if (!daxctl_dev_get_memory())
is_devdax..."

I also think it's ok to treat disabled device instances as devdax mode
as "unknown" will just increase user anxiety.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
