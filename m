Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2B216644
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 May 2019 17:10:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7C3BE2125582A;
	Tue,  7 May 2019 08:09:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8412921237AB8
 for <linux-nvdimm@lists.01.org>; Tue,  7 May 2019 08:09:56 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id o39so15225423ota.6
 for <linux-nvdimm@lists.01.org>; Tue, 07 May 2019 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7B0YY/tuwYgSrVIfUPS1cgz9LxSrbQPkHLz8B/p2y2k=;
 b=FfrRoNiW2mqPyRdm+Nc6T26ie1KUmZiB8g8NJpOEz+itth0sQuL/nCF/kQjKsdZkul
 PXSf4dULc+bFlcloKFVfMNq3RbFquJOLQEcSHhKjpodw03sRBfMddCY4qkMAQfR44OdX
 DITETRUBDe82rvbvHBxX/uAdT759KWoE8SBZh5Xq1XsEIRFyhnV/soh4jaPoMqnYHG2D
 3f3YNfo+BwBRIqOCn55ArQt6m/JOGYKZLcKidrS4fzIbucvP+yFSdd2gQC5XIyiQbRox
 PQEMSgyvWjS5m4dT9pbbNU+mf3C8DXxgJPh94oqQQKCSBDudx+SvPKXfsIGSY0BENgk0
 VXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7B0YY/tuwYgSrVIfUPS1cgz9LxSrbQPkHLz8B/p2y2k=;
 b=cu9yVM/17wToGBXl4KgaONhOJpqSKKWgFOBzy2Jy3A2OPIPbY8USuf5O2mbjM8u4Db
 X7GW4gJdujRGaBXtT5R4O2uMhobbEUWw9jDRTegIrem9NB00srdImkX2xgr7O4+GY669
 XoQ0jtX236V4bQTjZ5pNjzd5Dl9w6/ewgXt8Dx29sz3zDzxdW1FDcyNJ23kC+XoDXf6Z
 KIF6zQnAtJIwzoRiYMNKsntjK3g7e3pfA+7F9nB1vxmPQV6CX7JKjm5ob26GYARaqD8s
 cYls681RPXi8lv9fK6OWPNt0YuSByBVILzQgqjT6A2YAjpo+GHy5zG6ELSbm2ahf+9FS
 LAoA==
X-Gm-Message-State: APjAAAWIS/lApyPo2A3C6wJt1vuDdyyPdHtNjeFomvAecjiOVx7xyQkO
 vjXd/5QgtsoD7hvjgUHTA4sqQr6BN8yg178KlBKkEw==
X-Google-Smtp-Source: APXvYqzbDPGe8upi/eqDgtg9Nkitw8XKPSXhVZF9UexfGpCo0Vyt40wC/xRq29IX5XuEtHL2HlKBUOKn8giE61p9obk=
X-Received: by 2002:a9d:6a96:: with SMTP id l22mr13049733otq.98.1557241796269; 
 Tue, 07 May 2019 08:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190401051421.17878-1-aneesh.kumar@linux.ibm.com>
 <87pnoumql8.fsf@linux.ibm.com>
In-Reply-To: <87pnoumql8.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 May 2019 08:09:45 -0700
Message-ID: <CAPcyv4go1Ya=D-8O2JjecRA4GRDH1PdhntzjaxhYUQa+-srLiQ@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/dax: Allow to include DEV_DAX_PMEM as builtin
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
Cc: Linux MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 7, 2019 at 4:50 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
>
> Hi Dan,
>
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
> > This move the dependency to DEV_DAX_PMEM_COMPAT such that only
> > if DEV_DAX_PMEM is built as module we can allow the compat support.
> >
> > This allows to test the new code easily in a emulation setup where we
> > often build things without module support.
> >
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>
> Any update on this. Can we merge this?

Applied for the v5.2 pull request.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
