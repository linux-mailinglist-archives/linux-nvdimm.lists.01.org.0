Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA8E1A0634
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Apr 2020 07:12:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 080D61100B15F;
	Mon,  6 Apr 2020 22:13:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::942; helo=mail-ua1-x942.google.com; envelope-from=dewisandra154@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 545751100B15B
	for <linux-nvdimm@lists.01.org>; Mon,  6 Apr 2020 22:13:32 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g10so844427uae.5
        for <linux-nvdimm@lists.01.org>; Mon, 06 Apr 2020 22:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=38NlpNEbzNFWb7RFQtfvRASB+B576yw7dNc7pozf3pc=;
        b=m9m/DCsFRus/zRmIuphflM5sHyenmkMN/TOEnECOGthbLJHVg8u2+iqtFZpNbyb2/k
         2tLF//qwyXGtNVJKRleGUy+KbEtVjN+06Aw6FbGL98d5M/QEqB9c9SHaIsBPFlQYoUCh
         Lj+P9EPUGdvyQRip4KeH3oSvDVhqDTV0IJcbcI66BzYP/b9Y/1y4LF++1q0teLhPl3GM
         v15gBTxOBB8qvH4CNaCnwdm2sugBL+St8qIlm7SqBWweWj6hdsos1F0mjeWO8qJt64R9
         xl3tya8AfljNAFdSOkZ4tC7INitomO8JQPFHHcp+JAODUsaup01At9KIYDntXEoTQZb0
         DmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=38NlpNEbzNFWb7RFQtfvRASB+B576yw7dNc7pozf3pc=;
        b=rBzRLULKsMC8DmGf2qzjMVD/QXjnrzgBljDG3lhUswgnjfmz8HIQBMjKXcGjDOcL6m
         6JbIWgD1k6KWjgGgt6Z+drfmuWripgg7oVtHx69vhz4oWKVhY8GnYYQyluVf0rhw7wFZ
         zA4QRJ2n5k0svkyRdWLcjcGB6lNB8hY8bO85pRJJIQeR2GfSncb+pcCeVu9PfGQI87vH
         KPyIQcQrCDm+dIBoq7B5fKePYk0QUHM8yhnykvaTwsSKgZ5UBHpdWDCJ0dOcyijScPpE
         q/Xp5FO2td0jqrXz/2DGiUXg6EXLeJYygiY8YaC9ewD7gK2l5IMUqntAzsmcZX8liSF8
         eanQ==
X-Gm-Message-State: AGi0PuaPdTn5o2cEPR21qCbFteDwSEHjx2QANZpjPVKlbiveEX4a031e
	4FZGvEnQHlgN9mHStxhhx/z1XY0g0UfdlmsIqHg=
X-Google-Smtp-Source: APiQypIYXniGQUHEpASwiGNjKth4Cu9ElCz4yjrJ2uXbYBYunhfz0887D/TRydUbTstl7MwaeVftG8QxF1P80ST3qos=
X-Received: by 2002:ab0:a9:: with SMTP id 38mr504317uaj.61.1586236361040; Mon,
 06 Apr 2020 22:12:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:4929:0:0:0:0:0 with HTTP; Mon, 6 Apr 2020 22:12:40 -0700 (PDT)
From: SANDRA DEWI <dewisandra154@gmail.com>
Date: Tue, 7 Apr 2020 05:12:40 +0000
Message-ID: <CABRVPWys0xe4CWBkaU0ZXQW+4d=tjDOjyo8cKohc5-VFkWPkcA@mail.gmail.com>
Subject: whether this is your correct email address or not
To: undisclosed-recipients:;
Message-ID-Hash: RP2WBLRGI2SBRH6YBF7TGYYPIIBBBM7I
X-Message-ID-Hash: RP2WBLRGI2SBRH6YBF7TGYYPIIBBBM7I
X-MailFrom: dewisandra154@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RP2WBLRGI2SBRH6YBF7TGYYPIIBBBM7I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear ,Pastor



I have a client who is an oil business man and he made a fixed deposit
of $26 million USD in my bank, where I am the director of the branch,
My client died with his entire family in Jordanian

50% of the fund will be for the church  for the work of God,the
balance 50% we share it in the ratio of 50/50. Meaning 50% to you and
50% for me

intervention in the Syrian Civil War 2014 leaving behind no next of
kin. I Propose to present you as next of kin to claim the funds, if
interested reply me for full details and how we are to



proceed to close this deal.




Mrs. Sandra Dewi



Email  mrsdewi@gmx.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
