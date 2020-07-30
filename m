Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B3823379B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Jul 2020 19:23:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A109112763C9D;
	Thu, 30 Jul 2020 10:23:26 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com; envelope-from=jhoanaradanas@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BCB481274B2FF
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jul 2020 10:23:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l2so15087501wrc.7
        for <linux-nvdimm@lists.01.org>; Thu, 30 Jul 2020 10:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HhrW5h522nx1YNGcmO/mmV2ZrGewtypCZnAXO6YwEu8=;
        b=OThqmGHTHlxl7K472+YMZI4ayOUtYFWW0BiM8/N1vxBNkDBrhyIKzUdjIx9kYvko2+
         Z/d7HxDeQPIKs3lLTU7CQR3TG4gmRrbTF+sFu4Bi3hXuiY5DtutbKXDLCPaA9g4PlMu1
         3BWnRoWmqJeyQU39+Z63F/92ELz+dRBKxIpjBEFEMRadIISI9RoBjGGeYC2o7I5pKqb2
         5/6cxBlxPLOpoL6m83qI3oEmeGYKW08FwnoJu3jW7HyDN9D+GRAovRNBEEtM8HPAGg7k
         dFJygEexbJBCIWmRYH82xWptrFLdQzfTaSRGw/DcuoWt1pQ60FDxPt50PJQ+uDGuaiRW
         +0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HhrW5h522nx1YNGcmO/mmV2ZrGewtypCZnAXO6YwEu8=;
        b=sE6MCiR/jamyWBZD75j0fnUy7trxlwXkP/3PZbKrk0enm6NiE37Z1Gux30aLGoZDel
         1cEt+SaZFQsF74n4YV+NOt0bWPDOglt4+FOjpqIDs2mSWd+SF1miC8TVATDoniFNAe4T
         0/7Bm6u1vXm2/2dl6YKFMOf/8xzPjgfvK4TVfz8NUtFUCee/WTyO1e0R6AgptMD+spfy
         wo9VzKpdb/EflbP7sgoaGY+J2RBNL0AD5S2vfg7xUh/RLMkkjR5dF8rzAmTOQHF2cyAV
         eFrCSTVYdYidzBxYojJdasPOOppKfrPYKCCPwHvAs/MD745+M9zJkoPlC7BuJDsqTIUi
         88CQ==
X-Gm-Message-State: AOAM532Yab7KVkKK7ECMQ8Y6xSzAvfVeRoqTAtfGcg5/Yll67YBoNdtM
	GjMJGr3tiOyuGBiJ1VlNJXWS679KymETfaYUNBcoyQ==
X-Google-Smtp-Source: ABdhPJwI+3d6WKrfqDG+r4iGgXF/afqwF975YhujOjxHthGzWqPrnoJtpHjFE7fVfY4t2OcrFlwxjUAhFUjqah1ZThg=
X-Received: by 2002:adf:c983:: with SMTP id f3mr3653661wrh.348.1596129801374;
 Thu, 30 Jul 2020 10:23:21 -0700 (PDT)
MIME-Version: 1.0
From: Jhoan Aradanas <jhoanaradanas@gmail.com>
Date: Fri, 31 Jul 2020 01:23:07 +0800
Message-ID: <CAMvTTZp7+jW+kmYhMiciFOqFVama25EeLA8oEKcby2y=FWjrog@mail.gmail.com>
Subject: 
To: linux-nvdimm@lists.01.org
Message-ID-Hash: ZQZ3ASFMHWFKNVAH6SZFIJ7GJZ24XCZO
X-Message-ID-Hash: ZQZ3ASFMHWFKNVAH6SZFIJ7GJZ24XCZO
X-MailFrom: jhoanaradanas@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZQZ3ASFMHWFKNVAH6SZFIJ7GJZ24XCZO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
